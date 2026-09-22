package dmit2015.view;

import jakarta.enterprise.context.SessionScoped;
import jakarta.inject.Named;

import java.io.Serializable;

@Named
@SessionScoped
public class EnrollmentBean implements Serializable {
    private String studentName;
    private String programName;
    private boolean onlineDelivery;

    public String submit() {
        return "enrollment-confirmation?faces-redirect=true";
    }

    public String getDeliveryMode() {
        if(onlineDelivery) {
            return "Online";
        }
        return "In-Person";
    }
    // Generate getters/setters

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getProgramName() {
        return programName;
    }

    public void setProgramName(String programName) {
        this.programName = programName;
    }

    public boolean isOnlineDelivery() {
        return onlineDelivery;
    }

    public void setOnlineDelivery(boolean onlineDelivery) {
        this.onlineDelivery = onlineDelivery;
    }
}
