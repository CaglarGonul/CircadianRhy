package game_db.entity;
// Generated 08-Sep-2012 14:13:48 by Hibernate Tools 3.2.1.GA


import java.util.Date;

/**
 * Serverlvlipban generated by hbm2java
 */
public class Serverlvlipban  implements java.io.Serializable {


     private Integer serveripbanid;
     private Userlogin userlogin;
     private Dbzone dbzone;
     private String bannedip;
     private String bansebep;
     private Date banstart;
     private Date banend;

    public Serverlvlipban() {
    }

    public Serverlvlipban(Userlogin userlogin, Dbzone dbzone, String bannedip, String bansebep, Date banstart, Date banend) {
       this.userlogin = userlogin;
       this.dbzone = dbzone;
       this.bannedip = bannedip;
       this.bansebep = bansebep;
       this.banstart = banstart;
       this.banend = banend;
    }
   
    public Integer getServeripbanid() {
        return this.serveripbanid;
    }
    
    public void setServeripbanid(Integer serveripbanid) {
        this.serveripbanid = serveripbanid;
    }
    public Userlogin getUserlogin() {
        return this.userlogin;
    }
    
    public void setUserlogin(Userlogin userlogin) {
        this.userlogin = userlogin;
    }
    public Dbzone getDbzone() {
        return this.dbzone;
    }
    
    public void setDbzone(Dbzone dbzone) {
        this.dbzone = dbzone;
    }
    public String getBannedip() {
        return this.bannedip;
    }
    
    public void setBannedip(String bannedip) {
        this.bannedip = bannedip;
    }
    public String getBansebep() {
        return this.bansebep;
    }
    
    public void setBansebep(String bansebep) {
        this.bansebep = bansebep;
    }
    public Date getBanstart() {
        return this.banstart;
    }
    
    public void setBanstart(Date banstart) {
        this.banstart = banstart;
    }
    public Date getBanend() {
        return this.banend;
    }
    
    public void setBanend(Date banend) {
        this.banend = banend;
    }




}


