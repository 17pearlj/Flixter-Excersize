# Project 2 - **Flixter**

**Flixter** is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: **16** hours spent in total

## User Stories

The following **required** functionality is complete:

- [X] User can view a list of movies currently playing in theaters from The Movie Database.
- [X] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [X] User sees a loading state while waiting for the movies API.
- [X] User can pull to refresh the movie list.

The following **optional** features are implemented:

- [X] User sees an error message when there's a networking error.
- [X] Movies are displayed using a CollectionView instead of a TableView.
- [X] User can search for a movie.
- [X] All images fade in as they are loading.
- [X] User can view the large movie poster by tapping on a cell.
- [ ] For the large poster, load the low resolution image first and then switch to the high resolution image when complete.
- [X] Customize the selection effect of the cell.
- [X] Customize the navigation bar.
- [X] Customize the UI.

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!
- [x] trailer videos are available on the details page
- [x] 3rd party loading icon

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. helper function files that can be used by multiple files, how do we import/use those?
2. how would we upload this app?

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='http://g.recordit.co/2iqlJnQwO3.gif' title='Video Walkthrough' width='250' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.
Nothing was overly, frustratingly challenging. I was able to create objective-c functions (the language is new to me), working with the movie API was new but understandable. Understanding further functionality of X-Code is what I am looking forward to.
## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.
- [SVProgressHUD](https://github.com/SVProgressHUD/SVProgressHUD) - loading 
- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library

## License

Copyright [2019] [name of copyright owner]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
