# Web Configurator for Streamer.bot Extensions

This Streamer.bot utility lets extension authors add a browser-based UI to their extension, giving their users an easier way to set up and configure their extension. It is an alternative to telling them to add or edit `Set Argument` subactions, or to code a custom Windows UI with WinForms or WPF.

### Why Use It?

* Web Configurator is Cross-platform, working equally well on Linux and Mac
* Independent of the Windows UI framework du jour.

### Why Not Use It?

* You don't want your configuration kept in Streamer.bot global variables.
* Your configuration data is too complex to represent as a set of individual values.

## Usage

To include the Web Configurator UI in your extension:

1. Import the [WebConfigurator.sb](https://raw.githubusercontent.com/WhazzItToYa/Streamerbot-WebConfigurator/refs/heads/main/WebConfig.sb) into your Streamer.bot
2. As a part of your extension, create a configuration action that the user can invoke (e.g., via a Test trigger). In that action, add the subactions:
    * Set Argument "configSpec" to "{your json config descriptor}" (see below for what this looks like)
    * Run Action "WC - Open Configuration"
    
When your user runs this action, it will open their browser to a page that allows them to edit all of the configuration options you specified.

## The Configuration Descriptor

You specify the editable options of your extension in a JSON document. This document defines each configuration option that the user may edit.  Each object in the "options" array corresponds to one Streamer.bot global variable containing some piece of configuration data of your extension.

```javascript
{
    "title" : "Title of your Extension"
    "options" : [
        {
            "name" : "welcomeMessage", // S.bot variable name
            "type" : "text" | "password" | "number" | "bool" | "select" | "file",
            
            "label" : "Welcome message",           // Label to display (optional, defaults to "name")
            "description" : "New viewer greeting", // small help text (optional)
            "default" : "Welcome to the stream!",  // Initial value (optional)

            // Other options depending on "type":
            
            // For "number" type:
            
            "min" : 5,  // (optional) smallest number you can configure
            "max" : 10, // (optional) largest number you can configure
            "inc" : 0.5, // (optional) Allowed increments of the number
            
            // For "select" (i.e., dropdown list)
            
            "values" : [
                        "value1",     // First dropdown
                        "value2",     // Second dropdown
                        ["value314159", "pi"] // Third dropdown, Displays "pi" to user, but the stored value is "value314159"
                       ],

            // For "file" (a file picker)

            "accept" : "image/*,video/*,.webp", // The extensions or mime types to filter by
                       
        },
        ... more options ...
    ]
}

```

Example JSON: 

```json
{
    "title" : "Title of your Extension"
    "options" : [
        {
            "name" : "sample_aString",
            "type" : "string",
            "label" : "Option 1",
            "description" : "The value of the first option",
            "default" : "red"
        },
        {
            "name" : "sample_password",
            "type" : "password",
            "label" : "API Key",
            "description" : "Your API key"
        },
        {
            "name" : "sample_bool",
            "label" : "Boolean Setting",
            "description" : "Boolean true or false",
            "type" : "bool",
            "default" : "true"
        },
        {
            "name" : "sample_number",
            "label" : "a number",
            "description" : "1-5 by 0.5",
            "type" : "number",
            "min" : "1",
            "max" : "5",
            "inc" : "0.5",
            "default" : 4
        },
        {
            "name" : "sample_users",
            "label" : "Shoutout Users",
            "description" : "The usernames of those who get auto shoutouts",
            "type" : "list",
            "options" : [ ]
        },
        {
            "name" : "sample_file",
            "type" : "file",
            "label" : "A file chooser for images",
            "accept" : "image/*"
        },
        {
            "name" : "sample_select",
            "type" : "select",
            "values" : [
                "This", "That", ["other", "The Other"]
            ]
        }

    ]
}

```
