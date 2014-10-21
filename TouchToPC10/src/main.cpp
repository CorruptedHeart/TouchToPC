#include "touchtopc.h"
#include <Qt/qdeclarativedebug.h>

using ::bb::cascades::Application;

Q_DECL_EXPORT int main(int argc, char **argv)
{
    // Instantiate the main application constructor.
    Application app(argc, argv);

    // Initialize the app.
    TouchToPC mainApp;

    // We complete the transaction started in the main application constructor and start the
    // client event loop here. When loop is exited the Application deletes the scene which
    // deletes all its children (per QT rules for children).
    return Application::exec();
}
