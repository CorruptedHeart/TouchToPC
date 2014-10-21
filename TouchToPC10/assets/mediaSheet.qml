import bb.cascades 1.0

Page {
    id: mediaSheet
    paneProperties: NavigationPaneProperties {
        backButton: ActionItem {
            onTriggered: {
                navigationPane.pop();
            }
        }
    }
    content: ScrollView {
        scrollViewProperties.scrollMode: ScrollMode.Vertical
        scrollViewProperties.pinchToZoomEnabled: false
        scrollViewProperties.overScrollEffectMode: OverScrollEffectMode.OnScroll
        
        Container {
            id: mainMediaContainer
            layout: StackLayout {
            }
            Header {
                title: "Volume Control"
            }
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight

                }
                horizontalAlignment: HorizontalAlignment.Center

                Button {
                    text: "Volume Down"
                    onClicked: {
                        touchToPCApp.sendKeyPress("MEDIA-VD");
                    }
                }
                Button {
                    text: "Mute"
                    onClicked: {
                        touchToPCApp.sendKeyPress("MEDIA-VM");
                    }
                }
                Button {
                    text: "Volume Up"
                    onClicked: {
                        touchToPCApp.sendKeyPress("MEDIA-VU");
                    }
                }
            }
            Header {
                title: "Track Control"
            }
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight

                }
                horizontalAlignment: HorizontalAlignment.Center
                Button {
                    text: "<<"
                    onClicked: {
                        touchToPCApp.sendKeyPress("MEDIA-PT");
                    }
                }
                Button {
                    text: "STOP"
                    onClicked: {
                        touchToPCApp.sendKeyPress("MEDIA-STOP");
                    }
                }
                Button {
                    text: "|| |>"
                    onClicked: {
                        touchToPCApp.sendKeyPress("MEDIA-PLAY");
                    }
                }
                Button {
                    text: ">>"
                    onClicked: {
                        touchToPCApp.sendKeyPress("MEDIA-NT");
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
                DropDown {
                    id: mediaDrop
                    title: qsTr("Media App")
                    Option {
                        text: "Winamp"
                        description: "Winamp media player"
                        value: "winamp.exe"
                        selected: true
                    }
                    Option {
                        text: "iTunes"
                        description: "iTunes media player"
                        value: "iTunes.exe"
                    }
                    Option {
                        text: "Windows Media Player"
                        description: "Windows Media Player"
                        value: "wmplayer.exe"
                    }
                }
                Button {
                    text: qsTr("Open")
                    onClicked: {
                        if (mediaDrop.selectedIndex != -1) {
                            console.log("S:" + mediaDrop.selectedOption.value);
                            touchToPCApp.send("S:" + mediaDrop.selectedOption.value);
                        }
                    }
                }
            }
        }
    }
}