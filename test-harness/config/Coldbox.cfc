﻿component{
	// Configure ColdBox Application
	function configure(){
		// coldbox directives
		coldbox = {
			// Application Setup
			appName                 : "Module Tester",
			// Development Settings
			reinitPassword          : "",
			handlersIndexAutoReload : true,
			modulesExternalLocation : [],
			// Implicit Events
			defaultEvent            : "",
			requestStartHandler     : "",
			requestEndHandler       : "",
			applicationStartHandler : "",
			applicationEndHandler   : "",
			sessionStartHandler     : "",
			sessionEndHandler       : "",
			missingTemplateHandler  : "",
			// Error/Exception Handling
			exceptionHandler        : "",
			onInvalidEvent          : "",
			customErrorTemplate     : "/coldbox/system/exceptions/Whoops.cfm",
			// Application Aspects
			handlerCaching          : false,
			eventCaching            : false,
			autoMapModels           : false
		};

		// environment settings, create a detectEnvironment() method to detect it yourself.
		// create a function with the name of the environment so it can be executed if that environment is detected
		// the value of the environment is a list of regex patterns to match the cgi.http_host.
		environments = { development : "localhost,127\.0\.0\.1" };

		// Module Directives
		modules = {
			// An array of modules names to load, empty means all of them
			include : [],
			// An array of modules names to NOT load, empty means none
			exclude : []
		};

		// Register interceptors as an array, we need order
		interceptors = [];

		// LogBox DSL
		logBox = {
			// Define Appenders
			appenders : {
				files : {
					class      : "coldbox.system.logging.appenders.RollingFileAppender",
					properties : { filename : "tester", filePath : "/#appMapping#/logs" }
				},
				console : { class : "coldbox.system.logging.appenders.ConsoleAppender" }
			},
			// Root Logger
			root  : { levelmax : "DEBUG", appenders : "*" },
			// Implicit Level Categories
			info  : [ "coldbox.system" ],
			debug : [ "cbmailservices" ]
		};

		// Module Settings
		moduleSettings = {
			cbmailservices : {
				// The default token Marker Symbol
				tokenMarker     : "@",
				// Default protocol to use, it must be defined in the mailers configuration
				defaultProtocol : "default",
				// Here you can register one or many mailers by name
				mailers         : {
					"cfmail" : { class : "CFMail" },
					"files" : { class : "File", properties : {
						filePath = "/root/logs"
					}},
					"default" : { class : "InMemory" }
				},
				// The defaults for all mail config payloads and protocols
				defaults        : {
					to : "info@ortussolutions.com",
					from : "info@ortussolutions.com",
					cc : "lmajano@ortussolutions.com"
				}
			}
		};
	}

	/**
	 * Load the Module you are testing
	 */
	function afterConfigurationLoad( event, interceptData, rc, prc ){
		controller
			.getModuleService()
			.registerAndActivateModule( moduleName = request.MODULE_NAME, invocationPath = "moduleroot" );
	}
}
