import bb.cascades 1.0
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
                    onVisibleChanged: {
                        if (visible) {
                            var text = myValue.split(".", 4);
                            for (var i = 0; i < 4; i ++) {
                                select(i, text[i], ScrollAnimation.None);
                            }
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