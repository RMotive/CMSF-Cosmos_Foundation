# CHANGELOG

## 0.0.1

* Started version, when there are created handlers and hooks to simplifie the starter widget MaterialApp.
* Created an optional Theme handler.
* Created a simplified routing handler.

## 1.0.0

### Conditionals

* Changed the ResponsiveView widget to conditionals pack.

### Helpers

* Improved the API and logical calcaultions for Advisor (NO MORE SINGLETON).
  * Added the option to set additional information.
  * Added the startWithUpper property and management to decide if the header message should start with upper-case or not.
  * Added the colorization as properties when the object is created.
  * Added adviseMessage to write single advise messages.
* Added the Responsive helper that provides powerful methods to calculate dynamic response properties.
  * With a method to calculate traditional breakpoints as small, medium, and large devices.
  * With a mehtod to calculate powerful dynamic breakpoints and values during runtime.  
  * Added a shortcut to indicate if the current window is larger.
  * Small improvements in the internal objects management.
* Improved theme helper documentation and API communication.
  * Added an updateEffect to getTheme method to notify all stateful widgets listeners about
  the update of the current theme to use.  
  * Added an disposeGetTheme to remove listeners from stateful widgets when they are disposed.
