package dmit2015.view;

import jakarta.faces.application.FacesMessage;
import jakarta.faces.context.FacesContext;
import jakarta.faces.view.ViewScoped;
import jakarta.inject.Named;

import java.io.Serializable;

@Named
@ViewScoped
// can save information on dynamic page - need view scope and serial
public class StudentFormBean implements Serializable {
    private int submissionCount; //getter
    private String fullName; // getter & setter needed
    private String program; // getter & setter needed
    private boolean fullTime; //getter & setter needed

    public void submit() {
        submissionCount++;
        String messagesDetail = String.format("Full name:%s", fullName, program, fullTime);
        FacesMessage message = new FacesMessage(
                FacesMessage.SEVERITY_INFO,
                "Form Submitted",
                messagesDetail
        );
        FacesContext.getCurrentInstance()
                .addMessage(null, message);
        fullName = null;
        program = null;
    }

    public int getSubmissionCount() {
        return submissionCount;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getProgram() {
        return program;
    }

    public void setProgram(String program) {
        this.program = program;
    }

    public boolean isFullTime() {
        return fullTime;
    }

    public void setFullTime(boolean fullTime) {
        this.fullTime = fullTime;
    }
}
