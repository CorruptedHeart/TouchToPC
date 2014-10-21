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
    Container {
        layout: StackLayout {
            orientation: LayoutOrientation.LeftToRight

        }
        horizontalAlignment: HorizontalAlignment.Center
        TextField {
            id: debugField
            hintText: "Enter Command"
            input.flags: TextInputFlag.SpellCheckOff
            input.submitKey: SubmitKey.Send
            input.onSubmitted: {
                touchToPCApp.send(debugField.text);
            }
        }
        Button {
            text: "Send"
            onClicked: {
                touchToPCApp.send(debugField.text);
            }
        }
    }
}