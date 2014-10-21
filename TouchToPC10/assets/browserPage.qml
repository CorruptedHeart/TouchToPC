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
            Button {
                text: "^"
                onClicked: {
                    touchToPCApp.sendKeyPress("ARROW-UP");
                }
                preferredWidth: 20.0
                maxWidth: 20.0
                minWidth: 20.0
            }
        }
        Container {
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight

            }
            horizontalAlignment: HorizontalAlignment.Center
            Button {
                text: "<"
                preferredWidth: 20.0
                maxWidth: 20.0
                minWidth: 20.0
                onClicked: {
                    touchToPCApp.sendKeyPress("ARROW-LEFT");
                }
            }
            Button {
                text: "v"
                preferredWidth: 20.0
                maxWidth: 20.0
                minWidth: 20.0
                onClicked: {
                    touchToPCApp.sendKeyPress("ARROW-DOWN");
                }
            }
            Button {
                text: ">"
                preferredWidth: 20.0
                maxWidth: 20.0
                minWidth: 20.0
                onClicked: {
                    touchToPCApp.sendKeyPress("ARROW-RIGHT");
                }
            }
        }
    }
}