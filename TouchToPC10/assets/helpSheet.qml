import bb.cascades 1.0

Page {
    id: helpSheet
    paneProperties: NavigationPaneProperties {
        backButton: ActionItem {
            onTriggered: {
                navigationPane.pop();
            }
        }
    }
    Container {
        Header {
            title: "Help"
        }
        Label {
            multiline: true
            text: "To be used in conjunction with computer software\nhttps://dl.dropboxusercontent.com/u/43996324/Icon.png"
        }
        Header {
            title: "Credits"
        }
        Label {
            multiline: true
            text: "Developed by Garth de Wet\nCopyright 2013"
        }
    }
}