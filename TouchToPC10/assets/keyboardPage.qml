import bb.cascades 1.0

Page {
    id: keyboardPage
    paneProperties: NavigationPaneProperties {
        backButton: ActionItem {
            onTriggered: {
                navigationPane.pop();
            }
        }
    }
    property bool readyForFocus: false
    Container {
        id: mainKeyboardContainer
        layout: StackLayout {
        }
        Container {
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                horizontalAlignment: HorizontalAlignment.Center
                Button {
                    text: "<--"
                    onClicked: {
                        textEntry.requestFocus();
                        touchToPCApp.sendKeyPress("BACKSPACE");
                    }
                }
                Button {
                    text: "Delete"
                    onClicked: {
                        textEntry.requestFocus();
                        touchToPCApp.sendKeyPress("DELETE");
                    }
                }
            }
            TextArea {
                id: textEntry
                hintText: ""
                input.flags: TextInputFlag.SpellCheckOff | TextInputFlag.AutoCapitalizationOff | TextInputFlag.PredictionOff
                onTextChanging: {
                    if (text != "") {
                        touchToPCApp.sendKeyPress(text);
                        textEntry.text = "";
                    }
                }
                input.onSubmitted: {
                    touchToPCApp.sendKeyPress("ENTER");
                }
            }
        }
    }

    onReadyForFocusChanged: {
        if (readyForFocus) {
            textEntry.requestFocus();
            textEntry.visible = false;
        }
    }
}