// https://github.com/jquery-boilerplate/jquery-boilerplate/blob/master/src/jquery.boilerplate.js
//
// the semi-colon before function invocation is a safety net against concatenated
// scripts and/or other plugins which may not be closed properly.
//
// undefined is used here as the undefined global variable in ECMAScript 3 is
// mutable (ie. it can be changed by someone else). undefined isn't really being
// passed in so we can ensure the value of it is truly undefined. In ES5, undefined
// can no longer be modified.
//
// window and document are passed through as local variable rather than global
// as this (slightly) quickens the resolution process and can be more efficiently
// minified (especially when both are regularly referenced in your plugin).
;(function($, window, document, undefined) {
  "use strict";

  // Create the defaults once
  var pluginName = "{{_input_:pluginName}}";
  var dataKey = "plugin_" + pluginName;
  var defaults = {
    propertyName: "value"
  };

  // Private functions can access the plugin
  function privateFunction(plugin) {
    console.log("plugin.settings.propertyName = ", plugin.settings.propertyName);
  }

  // The actual plugin constructor
  function Plugin (element, options) {
    this.element = element;
    // jQuery has an extend method which merges the contents of two or
    // more objects, storing the result in the first object. The first object
    // is generally empty as we don't want to alter the default options for
    // future instances of the plugin
    this.settings = $.extend({}, defaults, options);
    this._name = pluginName;
    this.init();
  }

  // Avoid Plugin.prototype conflicts
  $.extend(Plugin.prototype, {
    init: function() {
      // Place initialization logic here
      // You already have access to the DOM element and
      // the options via the instance, e.g. this.element
      // and this.settings
      console.log("xD");

      // Calling a private function that dont have access to "this",
      // you need to pass the plugin
      privateFunction(this);

      // Calling a function that has access to "this"
      this.yourOtherFunction();
    },

    yourOtherFunction: function() {
      // some logic
    },

    publicFunction: function() {
      console.log("public function with propertyName = ", this.settings.propertyName);
    }
  });


  // You don't need to change something below:
  // A really lightweight plugin wrapper around the constructor,
  // preventing against multiple instantiations and allowing any
  // public function (ie. a function whose name doesn't start
  // with an underscore) to be called via the jQuery plugin,
  // e.g. $(element).defaultPluginName("functionName", arg1, arg2)
  $.fn[pluginName] = function(options) {
    var args = arguments;

    // Is the first parameter an object (options), or was omitted,
    // instantiate a new instance of the plugin.
    if (options === undefined || typeof options === "object") {
      return this.each(function() {

        // Only allow the plugin to be instantiated once,
        // so we check that the element has no plugin instantiation yet
        if (!$.data(this, dataKey)) {

          // if it has no instance, create a new one,
          // pass options to our plugin constructor,
          // and store the plugin instance
          // in the elements jQuery data object.
          $.data(this, dataKey, new Plugin(this, options));
        }
      });

      // If the first parameter is a string and it doesn't start
      // with an underscore or "contains" the `init`-function,
      // treat this as a call to a public method.
    } else if (typeof options === "string" && options[0] !== "_" && options !== "init") {

      // Cache the method call
      // to make it possible
      // to return a value
      var returns;

      this.each(function() {
        var instance = $.data(this, dataKey);

        // Tests that there's already a plugin-instance
        // and checks that the requested public method exists
        if (instance instanceof Plugin && typeof instance[options] === "function") {

          // Call the method of our plugin instance,
          // and pass it the supplied arguments.
          returns = instance[options].apply(instance, Array.prototype.slice.call(args, 1));
        }

        // Allow instances to be destroyed via the "destroy" method
        if (options === "destroy") {
          $.data(this, dataKey, null);
        }
      });

      // If the earlier cached method
      // gives a value back return the value,
      // otherwise return this to preserve chainability.
      return returns !== undefined ? returns : this;
    }
  };
})(jQuery, window, document);
