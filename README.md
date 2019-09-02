# Welcome to FlickrSearch
FlickrSearch is an app that displays public Flickr Images by a tag-based search.

## Tech decision
- Used a collectionview, because the app can be extended to show more than one item per row in the future:
static let itemsPerRow: CGFloat = 1
- Used MVVM
- For the purpose of the exercise a textfield is used as the search field, but it can be replaced with a UISearchBar and SearchBarDisplayController


