---
layout: layouts/homepage.jinja
contentRenderers: 
  - markdown
  - jinja
---
## What is RSS?
[Really Simple Syndication (RSS)](https://www.rssboard.org/rss-specification) is an XML document 
format for announcing new blog posts, podcasts, and other media publications. For example, every 
podcast publishes an RSS feed, which is used by Spotify, Apple, and Amazon to discover new episodes.

--- 

## Parse an RSS feed
Whether your RSS feed comes from a file, or a URL, you should first obtain a string representation 
of the feed. Then you can parse it with `dart_rss`.

```dart
import ‘package:dart_rss/dart_rss.dart’;

final String rssFeed = ...

// Parse an RSS2 or later format.
final rss2 = RssFeed.parse(rssFeed);

// Parse an RSS1 format.
final rss1 = Rss1Feed.parse(rssFeed);

// Parse an ATOM format.
final atom = AtomFeed.parse(rssFeed);
```

---

## Built by the<br>Flutter Bounty Hunters
This package was built by the [Flutter Bounty Hunters (FBH)](https://flutterbountyhunters.com). 
The Flutter Bounty Hunters is a development agency that works exclusively on open source Flutter 
and Dark packages.

With funding from corporate clients, the goal of the Flutter Bounty Hunters is to solve 
common problems for The Last Time™. If your team gets value from Flutter Bounty Hunter 
packages, please consider funding further development. 

### Other FBH packages
Other packages that the Flutter Bounty Hunters brought to the community...

[Super Editor, Super Text, Attributed Text](https://github.com/superlistapp/super_editor), [Static Shock](https://staticshock.io), 
[Follow the Leader](https://github.com/flutter-bounty-hunters/follow_the_leader), [Overlord](https://github.com/flutter-bounty-hunters/overlord),
[Flutter Test Robots](https://github.com/flutter-bounty-hunters/dart_rss), and more.

## Contributors
The `dart_rss` package was built by...

{{ components.contributors() }}