# Dart RSS
A dart package for parsing and generating RSS1.0, RSS2.0, and Atom feeds.

### Example
Import the package into your dart code using:
```
import 'package:dart_rss/dart_rss.dart';
```

To parse string into `RssFeed` object use:
```
var rssFeed = new RssFeed.parse(xmlString); // for parsing RSS 2.0 feed
var atomFeed = new AtomFeed.parse(xmlString); // for parsing Atom feed
var rss1Feed = new Rss1Feed.parse(xmlString); // for parsing RSS 1.0 feed
```

### Preview

**RSS**
```
feed.title
feed.description
feed.link
feed.author
feed.items
feed.image
feed.cloud
feed.categories
feed.skipDays
feed.skipHours
feed.lastBuildDate
feed.language
feed.generator
feed.copyright
feed.docs
feed.managingEditor
feed.rating
feed.webMaster
feed.ttl
feed.dc

RssItem item = feed.items.first;
item.title
item.description
item.link
item.categories
item.guid
item.pubDate
item.author
item.comments
item.source
item.media
item.enclosure
item.dc
```

**Atom**
```
feed.id
feed.title
feed.updated
feed.items
feed.links
feed.authors
feed.contributors
feed.categories
feed.generator
feed.icon
feed.logo
feed.rights
feed.subtitle

AtomItem item = feed.items.first;
item.id
item.title
item.updated
item.authors
item.links
item.categories
item.contributors
item.source
item.published
item.content
item.summary
item.rights
item.media
```

**RSS 1.0**
```
feed.title
feed.description
feed.link
feed.items
feed.image
feed.updatePeriod
feed.updateFrequency
feed.updateBase
feed.dc

Rss1Item item = feed.items.first;
item.title
item.description
item.link
item.dc
item.content
```

## Origin
This package was forked from [WebFeed](https://pub.dev/packages/webfeed).

@sudame continued work after the fork. 

In June, 2023, this package was transferred to @Flutter-Bounty-Hunters
