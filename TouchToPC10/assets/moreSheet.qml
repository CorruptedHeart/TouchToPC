import bb.cascades 1.0

Page {
    paneProperties: NavigationPaneProperties {
        backButton: ActionItem {
            onTriggered: {
                navigationPane.pop();
            }
        }
    }
    Container {
        Container {
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            horizontalAlignment: HorizontalAlignment.Center
            Button {
                text: qsTr("Media")
                onClicked: {
                    navigationPane.push(keyboardPageDefinition.createObject());
                }
                imageSource: "asset:///images/media.png"
            }
            Button {
                text: qsTr("Browser")
                onClicked: {
                    navigationPane.push(browserDefinition.createObject());
                }
            }
            Button {
                text: qsTr("Debug")
                onClicked: {
                    navigationPane.push(debugDefinition.createObject());
                }
            }
            attachedObjects: [
                ComponentDefinition {
                    id: keyboardPageDefinition
                    source: "mediaSheet.qml"
                },
                ComponentDefinition {
                    id: browserDefinition
                    source: "browserPage.qml"
                },
                ComponentDefinition {
                    id: debugDefinition
                    source: "debugPage.qml"
                }
            ]
        }
    }
}