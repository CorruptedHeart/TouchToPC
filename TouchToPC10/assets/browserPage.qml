import bb.cascades 1.0

Page {
    id: browserPage
    paneProperties: NavigationPaneProperties {
        backButton: ActionItem {
            onTriggered: {
                navigationPane.pop();
            }
        }
    }
    Container {
        id: mainBrowserContainer
        layout: StackLayout {
        }
        Header {
            title: "Page"
        }
        Container {
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight

            }
            horizontalAlignment: HorizontalAlignment.Center
            Button {
                text: "Page UP"
                onClicked: {
                    touchToPCApp.sendKeyPress("PAGEUP");
                }
            }
            Button {
                text: "F5"
                preferredWidth: 128.0
                maxWidth: 128.0
                minWidth: 128.0
                onClicked: {
                    touchToPCApp.sendKeyPress("REFRESH");
                }
            }
            Button {
                text: "Page DOWN"
                onClicked: {
                    touchToPCApp.sendKeyPress("PAGEDOWN");
                }
            }
        }
        Divider {

        }
        Container {
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight

            }
            horizontalAlignment: HorizontalAlignment.Center

            minHeight: 100.0
            preferredHeight: 100.0
            maxHeight: 100.0
            Button {
                text: "^"
                onClicked: {
                    touchToPCApp.sendKeyPress("ARROW-UP");
                }
                preferredWidth: 128.0
                maxWidth: 128.0
                minWidth: 128.0
                preferredHeight: 128.0
                minHeight: 128.0
                maxHeight: 128.0

            }
        }
        Container {
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            minHeight: 150
            preferredHeight: 150
            maxHeight: 150
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            Button {
                text: "<"
                onClicked: {
                    touchToPCApp.sendKeyPress("ARROW-LEFT");
                }
                preferredWidth: 128.0
                maxWidth: 128.0
                minWidth: 128.0
                preferredHeight: 128.0
                minHeight: 128.0
                maxHeight: 128.0
            }
            Button {
                text: "v"
                onClicked: {
                    touchToPCApp.sendKeyPress("ARROW-DOWN");
                }
                preferredWidth: 128.0
                maxWidth: 128.0
                minWidth: 128.0
                preferredHeight: 128.0
                minHeight: 128.0
                maxHeight: 128.0
            }
            Button {
                text: ">"
                onClicked: {
                    touchToPCApp.sendKeyPress("ARROW-RIGHT");
                }
                preferredWidth: 128.0
                maxWidth: 128.0
                minWidth: 128.0
                preferredHeight: 128.0
                minHeight: 128.0
                maxHeight: 128.0
            }
        }
    }
}