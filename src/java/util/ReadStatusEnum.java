/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

/**
 *
 * @author lmartins96
 */
public enum ReadStatusEnum {
    READ("read"), NOT_READ("not_read"), IN_PROGRESS("progress");

    private final String description;

    ReadStatusEnum(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }

}
