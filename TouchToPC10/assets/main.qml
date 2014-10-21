import bb.cascades 1.0
import bb.multimedia 1.0

NavigationPane {
    id: navigationPane

    onPopTransitionEnded: {
        Application.menuEnabled = true;
        page.destroy()
    }

    onPushTransitionEnded: {
        if (page != mainPage)
            Application.menuEnabled = false;
    }

    Menu.definition: MenuDefinition {
        helpAction: HelpActionItem {
            onTriggered: {
                var moreSheet = helpSheetDefinition.createObject();
                navigationPane.push(moreSheet);
            }
        }
        settingsAction: SettingsActionItem {
            onTriggered: {
                settingsSheet.open();
            }
        }
        actions: [
            ActionItem {
                title: "Reconnect"
                imageSource: "images/reload.png"
                onTriggered: {
                    touchToPCApp.Setup();
                }
            },
            ActionItem {
                title: "More"
                imageSource: "images/ic_overflow_action.png"
                onTriggered: {
                    var moreSheet = morePaneDefinition.createObject();
                    navigationPane.push(moreSheet);
                }
            },
            ActionItem {
                title: "Keyboard"
                imageSource: "images/ic_show_vkb.png"
                onTriggered: {
                    var page = keyboardSheetDefinition.createObject()
                    navigationPane.push(page);
                    page.readyForFocus = true;
                }
            }
        ]
    }
    Page {
        id: mainPage
        property alias ipText: ipPicker.myValue
        property alias portText: portField.text
        property alias passText: passField.text

        // Content Container
        content: Container {
            background: Color.create("#ff787878")
            layout: AbsoluteLayout {
            }
            attachedObjects: [
                // Media keys setup to function as Mouse Buttons.
                MediaKeyWatcher {
                    id: keyWatcherLeft
                    key: MediaKey.VolumeUp

                    onLongPress: {
                        touchToPCApp.sendButtonPress(0, 1);
                    }
                    onShortPress: {
                        touchToPCApp.sendButtonPress(0, 0);
                    }
                },
                MediaKeyWatcher {
                    id: keyWatcherRight
                    key: MediaKey.VolumeDown
                    onLongPress: {
                        touchToPCApp.sendButtonPress(1, 1);
                    }
                    onShortPress: {
                        touchToPCApp.sendButtonPress(1, 0);
                    }
                },
                MediaKeyWatcher {
                    id: keyWatcherMute
                    key: MediaKey.PlayPause

                    onLongPress: {
                        touchToPCApp.sendButtonPress(2, 1);
                    }
                    onShortPress: {
                        touchToPCApp.sendButtonPress(2, 0);
                    }
                },
                ComponentDefinition {
                    id: helpSheetDefinition
                    source: "helpSheet.qml"
                },
                ComponentDefinition {
                    id: keyboardSheetDefinition
                    source: "keyboardPage.qml"
                },
                ComponentDefinition {
                    id: morePaneDefinition
                    source: "moreSheet.qml"
                },
                // Different pages.
                Sheet {
                    id: settingsSheet
                    content: Page {
                        actions: [
                            ActionItem {
                                title: "Close"
                                ActionBar.placement: ActionBarPlacement.OnBar
                                onTriggered: {
                                    touchToPCApp.setIP(ipPicker.myValue);
                                    touchToPCApp.setPort(portField.text);
                                    touchToPCApp.setPassword(passField.text);
                                    touchToPCApp.Setup();
                                    settingsSheet.close();
                                }
                                imageSource: "images/ic_done.png"
                            }
                        ]
                        ScrollView {
                            id: scroller
                            scrollViewProperties.scrollMode: ScrollMode.Vertical
                            scrollViewProperties.pinchToZoomEnabled: false
                            scrollViewProperties.overScrollEffectMode: OverScrollEffectMode.OnScroll

                            Container {
                                Picker {
                                    id: ipPicker
                                    property string myValue: "192.168.0.4"
                                    title: "IP Address"
                                    description: ipPicker.myValue
                                    dataModel: XmlDataModel {
                                        source: "ipvalues.xml"
                                    }

                                    pickerItemComponents: [
                                        PickerItemComponent {
                                            type: "itemfirst"
                                            content: Container {
                                                layout: StackLayout {
                                                    orientation: LayoutOrientation.LeftToRight
                                                } // end of StackLayout
                                                Label {
                                                    text: pickerItemData.displayname
                                                } // end of Label
                                            } // end of Container
                                        }, // end of PickerItemComponent
                                        PickerItemComponent {
                                            type: "itemsecond"
                                            content: Container {
                                                layout: StackLayout {
                                                    orientation: LayoutOrientation.LeftToRight
                                                } // end of StackLayout
                                                Label {
                                                    text: pickerItemData.displayname
                                                } // end of Label
                                            } // end of Container
                                        }, // end of PickerItemComponent
                                        PickerItemComponent {
                                            type: "itemthird"
                                            content: Container {
                                                layout: StackLayout {
                                                    orientation: LayoutOrientation.LeftToRight
                                                } // end of StackLayout
                                                Label {
                                                    text: pickerItemData.displayname
                                                } // end of Label
                                            } // end of Container
                                        }, // end of PickerItemComponent
                                        PickerItemComponent {
                                            type: "itemfourth"
                                            content: Container {
                                                layout: StackLayout {
                                                    orientation: LayoutOrientation.LeftToRight
                                                } // end of StackLayout
                                                Label {
                                                    text: pickerItemData.displayname
                                                } // end of Label
                                            } // end of Container
                                        } // end of PickerItemComponent
                                    ] // end of pickerItemComponents
                                    onSelectedValueChanged: {
                                        myValue = ipPicker.selectedIndex(0).toString() + "." + ipPicker.selectedIndex(1).toString() + "." + ipPicker.selectedIndex(2).toString() + "." + ipPicker.selectedIndex(3).toString();
                                        ipPicker.description = myValue;
                                    }
                                    kind: PickerKind.Expandable
                                    preferredRowCount: 3
                                    onMyValueChanged: {
                                        var text = myValue.split(".", 4);
                                        for (var i = 0; i < 4; i ++) {
                                            select(i, text[i], ScrollAnimation.None);
                                        }
                                    }
                                }
                                Label {
                                    id: portLabel
                                    text: "Port"
                                }
                                TextField {
                                    id: portField
                                    hintText: "Port"
                                    textFormat: TextFormat.Plain
                                    inputMode: TextFieldInputMode.NumbersAndPunctuation
                                }
                                Label {
                                    id: passwordLabel
                                    text: "Password"
                                }
                                TextField {
                                    id: passField
                                    hintText: "Password"
                                    textFormat: TextFormat.Plain
                                    inputMode: TextFieldInputMode.Password
                                }
                            }
                        }
                    }
                }
            ]
            onTouch: {
                // Check for a press, if so, set the state variables we need
                if (event.isDown()) {
                    touchToPCApp.sendPosition(event.windowX, event.windowY);
                    touchPointImage.translationX = event.windowX;
                    touchPointImage.translationY = event.windowY;
                } else if (event.isMove()) {
                    touchToPCApp.sendPosition(event.windowX, event.windowY);
                    touchPointImage.translationX = event.windowX;
                    touchPointImage.translationY = event.windowY;
                }
            }
            ImageView {
                imageSource: "images/background.png"
                scalingMethod: ScalingMethod.AspectFit
            }
            ImageView {
                id: touchPointImage
                imageSource: "images/touchpoint.png"
                scalingMethod: ScalingMethod.None
            }
        }
    }
}