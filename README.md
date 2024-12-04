# abn-test-assignment

Project setup

- Use Wiki App to build the project on your device

Project description

- The assignment has been finished in ~10 hours which included project setup, writing code + tests coverage.

- The assignment has been done using iOS 18, language version Swift 5. Used Observable macro in the project which in supported by iOS version 17 and higher.

- UI is optimized for iPhone portrait mode. Rotation is possible.

- Used Localizable xcstings for English translations. Other translations are possible, no hardcoded strings in the project, keys are used which makes adding other languages very easy. 

- A11y is supported. System fonts and colors are used, both light and dark modes are supported. Accessibility label is used for the Location cell. Fonts are scalable according to the iPhone Display& Text size settings.

- I didnt use any of the 3rd party solutions. I prefer to use iOS SDK as much as possible and not rely on any external pods / swift pachages. In my opinion it makes it easier to maintain. Working on this assignment I didn't see any need to introduce any external solution.

- UI is built using SwiftUI. For the architecture desing patter I decided to go with the MVVM approach which I think suits the best.

- Networking is done using Async/Await. It uses one generic execute function so it makes it very easy to add any new methods to the APIClient if needed.

- UI is simple and straightforward. I decided to keep it simple to be able to finish the assignment on time and focus on other things if needed.

- Project is covered with Unit tests

What can be improved:

- Adding loading states and better handling of the error states.   

- Adding persistance storage for the newly added location.
