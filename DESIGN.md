I want a platform-agnostic way to bring up a configuration UI for streamerbot extensions. a Web page seems like a logical choice, since it has UI, and communication with streamer.bot via websockets.

USER Experience:


* As an extension author, I write an extension that keeps its user configuration options in persistent global variables. options include:
  * raw strings
    * optional regex pattern validation
  * numbers
    * int or float
    * min/max
    * increments
  * boolean
  * flie paths
  * 1-of-n select.
  * colors, dates, times, days, other? check the HTML input spec.
  * lists of single options above
  * lists of groups of options above (i.e., structs)

  * Logical relations between options?  e..g, if Bool(A) ==> 
  * Each option should have a label, and a descriptive help string

* As an author: I want to define those options in an easy format: json?


* As a user, I want a clear "Configure" action I can run a Test on, and it brings up the UI.
  * The UI contains any current values.
  * unconfigured values can have a default, or a suggested value.
  * If an option violates a rule, that is called out.
  * Explicit Save button?

DESIGN:

* Specifying configuration:
  * JSON string
    ```json
    {
      "title" : "Foo Configuration",
      "options" : [
        {
          "name" : "anOptionName",
          "label" : "Option 1", // optional, defaults to name
          "description" : "The value of the first option", // optional, defaults to nothing.
          "type" : "string", // optional, defaults to string
          "default" : "red", // optional
          "min" : "1", //optional, default no min
          "max" : "5", //optional, default no max
          "inc" : "0.5", //optional
        },
        {
          "name" : "users",
          "label" : "Shoutout Users",
          "description" : "The usernames of those who get auto shoutouts",
          "type" : "list",
          "options" : [
             // see top-level "options"
          ]
        }
      ]
    }
       
    ```
  * Execute a "Open Config" method

* Editing configuration:
  * Config-builder webpage is started
  * Webpage gets access to the configuration json string (how?)
    * A config ID is sent as a URL param to the webpage.
    * The webpage opens a websocket to streamer.bot, and requests the config ID, returning the json config.
  * Webpage dynamically builds out UI, which:
    * elements implement the config options
    * communicate changes in the values back to a "Setter" action.
  
