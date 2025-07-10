import { Application } from "@hotwired/stimulus"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
export const application = Application.start()

// Configure Stimulus development experience
window.Stimulus  = application
application.debug = false

eagerLoadControllersFrom("controllers", application)

