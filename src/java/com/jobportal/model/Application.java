package com.jobportal.model;

public class Application {
    private int id, jobId, seekerId;
    private String jobTitle, seekerName, resumePath, coverLetter, status, appliedDate;

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getJobId() { return jobId; }
    public void setJobId(int jobId) { this.jobId = jobId; }
    public int getSeekerId() { return seekerId; }
    public void setSeekerId(int seekerId) { this.seekerId = seekerId; }
    public String getJobTitle() { return jobTitle; }
    public void setJobTitle(String jobTitle) { this.jobTitle = jobTitle; }
    public String getSeekerName() { return seekerName; }
    public void setSeekerName(String seekerName) { this.seekerName = seekerName; }
    public String getResumePath() { return resumePath; }
    public void setResumePath(String resumePath) { this.resumePath = resumePath; }
    public String getCoverLetter() { return coverLetter; }
    public void setCoverLetter(String coverLetter) { this.coverLetter = coverLetter; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getAppliedDate() { return appliedDate; }
    public void setAppliedDate(String appliedDate) { this.appliedDate = appliedDate; }
}