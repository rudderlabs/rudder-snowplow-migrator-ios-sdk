<p align="center">
  <a href="https://rudderstack.com/">
    <img src="https://user-images.githubusercontent.com/59817155/121357083-1c571300-c94f-11eb-8cc7-ce6df13855c9.png">
  </a>
</p>

<p align="center"><b>The Customer Data Platform for Developers</b></p>

<p align="center">
  <b>
    <a href="https://rudderstack.com">Website</a>
    ·
    <a href="">Documentation</a>
    ·
    <a href="https://rudderstack.com/join-rudderstack-slack-community">Community Slack</a>
  </b>
</p>

---

# [](https://github.com/rudderlabs/rudder-snowplow-migrator-ios-sdk/blob/main/README.md)Rudderstack Snowplow Migrator SDK (iOS)

This iOS SDK helps you migrate from Snowplow to Rudderstack and requires minimal changes in your existing Snowplow iOS tracker implementation to get started and send events to Rudderstack.

## [](https://github.com/rudderlabs/rudder-snowplow-migrator-ios-sdk/blob/main/README.md#installing-the-javascript-sdk)Installing the iOS SDK

To migrate to RudderStack iOS SDK, follow the below steps:

1. Add the SDK to your `Podfile` as shown:

```ruby
pod 'RudderSnowplowMigrator', '1.0.0.beta.1'
```

2. Run the following command:

```ruby
pod install
```

3. Update your SDK initialization to any one of the following snippet (method 1, 2, or 3). Also, replace the `WRITE_KEY` and `DATA_PLANE_URL`.

```objectivec
//Method 1: Default values are considered for all the configuration objects 
//except networkConfiguration.
RSTracker *tracker = [RSTracker createTrackerWithWriteKey:WRITE_KEY network:networkConfig];

//Method 2: Default values are considered for all the configuration objects.
RSTracker *tracker = [RSTracker createTrackerWithWriteKey:WRITE_KEY dataPlaneUrl:DATA_PLANE_URL];

//Method 3: Values for all the configuration objects must be provided.
RSTracker *tracker = [RSTracker createTrackerWithWriteKey:WRITE_KEY network:networkConfig configurations:@[trackerConfig]];
```

### Write key and data plane URL

To integrate and initialize the iOS SDK, you will need the source write key and the data plane URL.

- To get the source write key, follow [**this guide**](https://www.rudderstack.com/docs/get-started/glossary/#write-key).
- To get the data plane URL, follow [**this guide**](https://www.rudderstack.com/docs/rudderstack-cloud/dashboard-overview/#data-plane-url).

## Updating class names

The below table lists the corresponding class names in Snowplow and RudderStack which need to be updated:

| Snowplow    |      RudderStack    | 
| :------------- | :-------------- |
| `NetworkConfiguration` | `RSNetworkConfiguration` | 
| `TrackerConfiguration` | `RSTrackerConfiguration` | 
| `SessionConfiguration` | `RSSessionConfiguration` | 
| `SubjectConfiguration` | `RSSubjectConfiguration` |
| `Structured` | `RSStructured` | 
| `ScreenView` | `RSScreenView` | 
| `Background` | `RSBackground` | 
| `Foreground` | `RSForeground` | 
| `SelfDescribing` | `RSSelfDescribing` | 
| `SelfDescribingJson` | `RSSelfDescribingJson` |
| `Snowplow` |  `RSTracker` | 
| `LogLevel` | `LogLevel` |

## Sending event data

You can migrate your existing events from Snowplow to RudderStack as described below:

### Identifying a user

Snowplow's <a href="https://docs.snowplow.io/docs/collecting-data/collecting-from-own-applications/mobile-trackers/tracking-events/">`SubjectConfiguration`</a> class can be used to identify the users.

### Tracking user actions

RudderStack SDKs support the following types of Snowplow events:

#### Custom structured events

RudderStack sends a `track` call for Snowplow events containing the <a href="https://docs.snowplow.io/docs/collecting-data/collecting-from-own-applications/mobile-trackers/tracking-events/#creating-a-structured-event">`Structured`</a> class.

In the below example, RudderStack maps `Action_example` to RudderStack event name and the rest of the properties, like `Category_example`, `label`, `value`, etc. to the RudderStack properties.

```objectivec
RSStructured * structured = [
  [RSStructured alloc] initWithCategory: @ "Category_example"
  action: @ "Action_example"
];
[structured label: @ "my-label"];
[structured property: @ "my-property"];
[structured value: @5];
[structured properties: @ {
  @ "key_1": @ "value_1", @ "key_2": @ "value_2"
}];

[tracker track: structured];
```

#### Custom self described events

RudderStack sends a `track` call for Snowplow events containing the <a href="https://docs.snowplow.io/docs/collecting-data/collecting-from-own-applications/mobile-trackers/tracking-events/#creating-a-structured-event">`SelfDescribing`</a> class.

In the below example, RudderStack maps `action` to the RudderStack event name.

```objectivec
// 1
RSSelfDescribingJson * selfDescribingJson = [
  [RSSelfDescribingJson alloc] initWithSchema: @ "schema"
  andDictionary: @ {
    @ "action": @ "Action_2", @ "key_2": @ "value_2"
  }
];
RSSelfDescribing * selfDescribing = [
  [RSSelfDescribing alloc] initWithEventData: selfDescribingJson
];

// 2
RSSelfDescribing * selfDescribing = [
  [RSSelfDescribing alloc] initWithSchema: @ "schema"
  payload: @ {
    @ "action": @ "Action_2", @ "key_2": @ "value_2"
  }
];

[tracker track: selfDescribing];
```

>`action` is a mandatory field. RudderStack does not send any call if it is absent.

#### Custom foreground events

RudderStack sends a `track` call for Snowplow events containing the <a href="https://docs.snowplow.io/docs/collecting-data/collecting-from-own-applications/mobile-trackers/previous-versions/objective-c-tracker/objective-c-1-0-0/#foreground-and-background-events">`Foreground`</a> class.

RudderStack sends the event name as `Application Opened` and maps the rest of the properties, like `index`, `properties`, etc. to the RudderStack properties.

```objectivec
RSForeground * foreground = [
  [RSForeground alloc] initWithIndex: @1
];
[foreground properties: @ {
  @ "key_1": @ "value_1"
}];

[tracker track: foreground];
```

>This is not an automatic lifecycle event. Hence, the properties like `version`, `build`, etc. are not present under `properties`.

#### Custom background events

RudderStack sends a `track` call for Snowplow events containing the <a href="https://docs.snowplow.io/docs/collecting-data/collecting-from-own-applications/mobile-trackers/previous-versions/objective-c-tracker/objective-c-1-0-0/#foreground-and-background-events">`Background`</a> class.

RudderStack sends the event name as `Application Backgrounded` and maps the rest of the properties, like `index`, `properties`, etc. to the RudderStack properties.

```objectivec
RSBackground * background = [
  [RSBackground alloc] initWithIndex: @1
];
[background properties: @ {
  @ "key_1": @ "value_1"
}];

[tracker track: background];
```

>This is not an automatic lifecycle event. Hence, the properties like `version`, `build`, etc. are not present under `properties`.

### Tracking page or screen views

Snowplow's <a href="https://docs.snowplow.io/docs/collecting-data/collecting-from-own-applications/mobile-trackers/tracking-events/#creating-a-structured-event">`ScreenView`</a> class captures whenever a new screen is loaded. A Snowplow event including the `ScreenView` class triggers the `screen` call in the RudderStack iOS SDK.

RudderStack maps the `name` to RudderStack event name and the rest of the properties, like `screenId`, `previousName`, `previousId`, etc. to the RudderStack properties.

```objectivec
RSScreenView * screen = [
  [RSScreenView alloc] initWithName: @ "DemoScreenName"
  screenId: [
    [NSUUID alloc] init
  ]
];
[screen type: @ "type"];
[screen previousName: @ "previousName"];
[screen previousId: @ "previousId"];
[screen previousType: @ "previousType"];
[screen transitionType: @ "transitionType"];
[screen viewControllerClassName: @ "viewControllerClassName"];
[screen topViewControllerClassName: @ "topViewControllerClassName"];
[screen properties: @ {
  @ "key_1": @ "value_1",
    @ "key_2": @ "value_2"
}];

[tracker track: screen];
```
