
import os
import importlib.util
import logging
from typing import Dict, Any, List, Callable

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

class DynastyPluginManager:
    """
    A plugin manager for the Dynasty geopolitical game.
    This class handles the loading, activation, and management of plugins.
    """

    def __init__(self, plugin_directory: str = "plugins"):
        self.plugin_directory = plugin_directory
        self.plugins: Dict[str, Any] = {}
        self.active_plugins: Dict[str, Any] = {}
        self.hook_registry: Dict[str, List[Callable]] = {}

    def discover_plugins(self) -> None:
        """
        Discover and load all plugins from the plugin directory.
        """
        logger.info(f"Discovering plugins in {self.plugin_directory}")
        for filename in os.listdir(self.plugin_directory):
            if filename.endswith(".py") and not filename.startswith("__"):
                plugin_name = os.path.splitext(filename)[0]
                plugin_path = os.path.join(self.plugin_directory, filename)
                self.load_plugin(plugin_name, plugin_path)

    def load_plugin(self, plugin_name: str, plugin_path: str) -> None:
        """
        Load a single plugin from the given path.

        Args:
            plugin_name (str): The name of the plugin.
            plugin_path (str): The file path to the plugin.
        """
        try:
            spec = importlib.util.spec_from_file_location(plugin_name, plugin_path)
            module = importlib.util.module_from_spec(spec)
            spec.loader.exec_module(module)

            if hasattr(module, "DynastyPlugin"):
                self.plugins[plugin_name] = module.DynastyPlugin()
                logger.info(f"Successfully loaded plugin: {plugin_name}")
            else:
                logger.warning(f"Plugin {plugin_name} does not contain a DynastyPlugin class")
        except Exception as e:
            logger.error(f"Failed to load plugin {plugin_name}: {str(e)}")

    def activate_plugin(self, plugin_name: str) -> None:
        """
        Activate a loaded plugin.

        Args:
            plugin_name (str): The name of the plugin to activate.
        """
        if plugin_name in self.plugins and plugin_name not in self.active_plugins:
            plugin = self.plugins[plugin_name]
            try:
                plugin.on_activate()
                self.active_plugins[plugin_name] = plugin
                logger.info(f"Activated plugin: {plugin_name}")
                self.register_plugin_hooks(plugin)
            except Exception as e:
                logger.error(f"Failed to activate plugin {plugin_name}: {str(e)}")
        elif plugin_name in self.active_plugins:
            logger.warning(f"Plugin {plugin_name} is already active")
        else:
            logger.warning(f"Plugin {plugin_name} not found")

    def deactivate_plugin(self, plugin_name: str) -> None:
        """
        Deactivate an active plugin.

        Args:
            plugin_name (str): The name of the plugin to deactivate.
        """
        if plugin_name in self.active_plugins:
            plugin = self.active_plugins[plugin_name]
            try:
                plugin.on_deactivate()
                del self.active_plugins[plugin_name]
                logger.info(f"Deactivated plugin: {plugin_name}")
                self.unregister_plugin_hooks(plugin)
            except Exception as e:
                logger.error(f"Failed to deactivate plugin {plugin_name}: {str(e)}")
        else:
            logger.warning(f"Plugin {plugin_name} is not active")

    def register_plugin_hooks(self, plugin: Any) -> None:
        """
        Register all hooks for a given plugin.

        Args:
            plugin (Any): The plugin instance to register hooks for.
        """
        for hook_name in dir(plugin):
            if hook_name.startswith("hook_"):
                hook_method = getattr(plugin, hook_name)
                if callable(hook_method):
                    if hook_name not in self.hook_registry:
                        self.hook_registry[hook_name] = []
                    self.hook_registry[hook_name].append(hook_method)
                    logger.debug(f"Registered hook {hook_name} for plugin {plugin.__class__.__name__}")

    def unregister_plugin_hooks(self, plugin: Any) -> None:
        """
        Unregister all hooks for a given plugin.

        Args:
            plugin (Any): The plugin instance to unregister hooks for.
        """
        for hook_name in list(self.hook_registry.keys()):
            self.hook_registry[hook_name] = [
                hook for hook in self.hook_registry[hook_name]
                if hook.__self__ != plugin
            ]
            if not self.hook_registry[hook_name]:
                del self.hook_registry[hook_name]
            logger.debug(f"Unregistered hooks for plugin {plugin.__class__.__name__}")

    def call_hook(self, hook_name: str, *args, **kwargs) -> List[Any]:
        """
        Call all registered functions for a given hook.

        Args:
            hook_name (str): The name of the hook to call.
            *args: Positional arguments to pass to the hook functions.
            **kwargs: Keyword arguments to pass to the hook functions.

        Returns:
            List[Any]: A list of results from all hook functions.
        """
        results = []
        if hook_name in self.hook_registry:
            for hook_func in self.hook_registry[hook_name]:
                try:
                    result = hook_func(*args, **kwargs)
                    results.append(result)
                except Exception as e:
                    logger.error(f"Error calling hook {hook_name}: {str(e)}")
        return results

    def get_plugin_info(self) -> Dict[str, Dict[str, Any]]:
        """
        Get information about all loaded plugins.

        Returns:
            Dict[str, Dict[str, Any]]: A dictionary containing information about each plugin.
        """
        plugin_info = {}
        for plugin_name, plugin in self.plugins.items():
            plugin_info[plugin_name] = {
                "name": plugin_name,
                "version": getattr(plugin, "version", "Unknown"),
                "author": getattr(plugin, "author", "Unknown"),
                "description": getattr(plugin, "description", "No description provided"),
                "is_active": plugin_name in self.active_plugins
            }
        return plugin_info

class DynastyPlugin:
    """
    Base class for Dynasty plugins. All plugins should inherit from this class.
    """

    def __init__(self):
        self.name = self.__class__.__name__
        self.version = "1.0.0"
        self.author = "Unknown"
        self.description = "No description provided"

    def on_activate(self) -> None:
        """
        Called when the plugin is activated. Override this method to perform any setup.
        """
        pass

    def on_deactivate(self) -> None:
        """
        Called when the plugin is deactivated. Override this method to perform any cleanup.
        """
        pass

# Example usage of the plugin system
if __name__ == "__main__":
    # Initialize the plugin manager
    plugin_manager = DynastyPluginManager()

    # Discover and load plugins
    plugin_manager.discover_plugins()

    # Activate a specific plugin
    plugin_manager.activate_plugin("ExamplePlugin")

    # Call a hook (assuming ExamplePlugin has implemented this hook)
    results = plugin_manager.call_hook("hook_on_turn_start", turn_number=1)
    print(f"Results from hook_on_turn_start: {results}")

    # Get information about all plugins
    plugin_info = plugin_manager.get_plugin_info()
    for plugin_name, info in plugin_info.items():
        print(f"Plugin: {plugin_name}")
        print(f"  Version: {info['version']}")
        print(f"  Author: {info['author']}")
        print(f"  Description: {info['description']}")
        print(f"  Active: {'Yes' if info['is_active'] else 'No'}")
        print()

    # Deactivate the plugin
    plugin_manager.deactivate_plugin("ExamplePlugin")

# Example plugin implementation
class ExamplePlugin(DynastyPlugin):
    def __init__(self):
        super().__init__()
        self.version = "1.0.1"
        self.author = "John Doe"
        self.description = "An example plugin for Dynasty"

    def on_activate(self):
        print(f"{self.name} has been activated!")

    def on_deactivate(self):
        print(f"{self.name} has been deactivated!")

    def hook_on_turn_start(self, turn_number: int):
        print(f"{self.name}: Turn {turn_number} is starting!")
        return f"Processed by {self.name}"

# More example plugins can be added here to demonstrate the extensibility of the system

class EconomyPlugin(DynastyPlugin):
    def __init__(self):
        super().__init__()
        self.version = "2.1.0"
        self.author = "Jane Smith"
        self.description = "Adds advanced economic features to Dynasty"

    def on_activate(self):
        print(f"{self.name} is enhancing the game's economy!")

    def on_deactivate(self):
        print(f"{self.name} has been removed. Economy returns to basic mode.")

    def hook_on_resource_change(self, resource: str, amount: int):
        print(f"{self.name}: Resource {resource} changed by {amount}")
        return {"resource": resource, "change": amount}

class DiplomacyPlugin(DynastyPlugin):
    def __init__(self):
        super().__init__()
        self.version = "1.5.2"
        self.author = "Diplomatic Dave"
        self.description = "Enhances diplomatic interactions between nations"

    def on_activate(self):
        print(f"{self.name} is improving international relations!")

    def on_deactivate(self):
        print(f"{self.name} has been deactivated. Diplomacy system reverts to default.")

    def hook_on_diplomatic_action(self, action: str, source_nation: str, target_nation: str):
        print(f"{self.name}: Diplomatic action '{action}' from {source_nation} to {target_nation}")
        return {"action": action, "source": source_nation, "target": target_nation}

# This extensive plugin system allows for easy expansion of the Dynasty game,
# enabling developers to add new features, modify game mechanics, and enhance
# the overall gameplay experience without modifying the core game code.
