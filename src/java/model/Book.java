/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import util.ReadStatusEnum;

/**
 *
 * @author Lucas Martins da Silva
 */
public class Book {

    private int id;
    private String name;
    private String author;
    private String gender;
    private String year;
    private int edition;
    private ReadStatusEnum readStatus;
    private int totalPages;
    private int readPages;

    public Book() {
    }

    public Book(int id, String name, String author, String gender, String year, int edition, ReadStatusEnum readStatus, int totalPages, int readPages) {
        this.id = id;
        this.name = name;
        this.author = author;
        this.gender = gender;
        this.year = year;
        this.readStatus = readStatus;
        this.totalPages = totalPages;
        this.readPages = readPages;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }
    
    public int getEdition() {
        return edition;
    }

    public void setEdition(int edition) {
        this.edition = edition;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public ReadStatusEnum getReadStatus() {
        return readStatus;
    }

    public void setReadStatus(ReadStatusEnum readStatus) {
        this.readStatus = readStatus;
    }
    
    public int getTotalPages() {
        return totalPages;
    }

    public void setTotalPages(int totalPages) {
        this.totalPages = totalPages;
    }

    public int getReadPages() {
        return readPages;
    }

    public void setReadPages(int readPages) {
        this.readPages = readPages;
    }
}
