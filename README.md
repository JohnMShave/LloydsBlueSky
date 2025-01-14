# LloydsBlueSky
Lloyds application challenge

## LloydsBlueSky

### Overview
A simple weather app showing the weather for a harcoded location.
The app has 3 screens demonstrating page, fullscreen cover and sheet presentation in SwiftUI using a simple Coordinator to isolate navigation logic.
The network service, model layer & repository types use generics to reeduce testing requirements and boiler plate code across the app.
The screens and views themselves are kept simple, serving to showcase the underlying features just mentioned.
A simple view component and modifier are extracted for purposes of illustration and re-used in a couple of places in the app.

The 3 screens are 
- Location Summary: showing the current day's high and low temperatures
- Daily: showing highs and lows for the upcoming week - days were hard coded to save time but the highs and lows are fetched from the back end service.
- Hourly: as above but stubbed out and only showing how the day (from tapping on a particular day's summary in daily view) is injected through to this sheet.

### Testing and code extendability and general notes
A sample of both Unit tests have been added to illustrate my understanding and highlight the simplicity brought of mocking brought by the templated resource protocol/type structure.
We can see how this would be easily extendable to other resource/repository types (e.g. File Stores or UserDefaults) and save (normally more complex) repository mocking etc.
With this approach we can also mix and match our decodables if not all are JSON etc by simply adding another resource protocol that implicitly knows it's resource type.

I believe the project amply demonstrates several if not all SOLID principles - 
-  Single responsibility: clearly apparent in several places
-  Inverse dependency & substiution principle: in the viewModels accepting repositories types as opposed to needing to know themselves how to fetch assets from backend
-  Open-closed: by the separation of view type addition from the actual coordinator code itself
-  Interface segregation: e.g. the summary view oly recieving its necessary data

I believe all of the above priniciples are worth aiming for if possible but one should apply pragmatism where needed.
The main benefit I think they bring is flexibility for further work and/or refactoring - as opposed to simply over-engineering for the sake of it.

### Comments
I like to think most of the code explains itself but have added comments to explain certain decisions and/or highlight the strengths of some architectural decisions.

No 3rd party libraries are used but there is nothing inherent in the project that would preclude some weclome additions such as the Shimmer package which adds nice loading effects etc.

https://github.com/user-attachments/assets/bd91a9c7-efe7-4fc7-ad41-60ac9038c5dc

