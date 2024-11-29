/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import model.Book;
import model.dao.BookDAO;
import util.ReadStatusEnum;

/**
 *
 * @author Lucas Martins da Silva
 */
public class BookController {

    public String add(String name, String author, String gender, String year, String edition, String readStatus, String totalPages, String readPages) throws ClassNotFoundException, ParseException {
        String message;
        BookDAO bookDAO = new BookDAO();
        Book newBook = new Book();
        ReadStatusEnum readStatusEnum = null;
        int totalPagesParsed = Integer.parseInt(totalPages);
        int readPagesParsed = 0;
        int editionParsed = 0;

        for (ReadStatusEnum value : ReadStatusEnum.values()) {
            if (value.getDescription().equals(readStatus)) {
                readStatusEnum = value;
            }
        }

        if (readPages != null && readPages.length() > 0) {
            readPagesParsed = Integer.parseInt(readPages);
        }

        if (edition != null && edition.length() > 0) {
            editionParsed = Integer.parseInt(edition);
        }

        if (readPagesParsed > totalPagesParsed) {
            return "O número de páginas lidas é maior que o total de páginas!";
        }

        newBook.setName(name);
        newBook.setAuthor(author);
        newBook.setGender(gender);
        newBook.setYear(year);
        newBook.setEdition(editionParsed);
        newBook.setReadStatus(readStatusEnum);
        newBook.setTotalPages(totalPagesParsed);
        newBook.setReadPages(readPagesParsed);

        try {
            if (bookDAO.add(newBook)) {
                message = "Livro adicionado com sucesso!";
            } else {
                message = "Erro ao cadastrar livro!";
            }
        } catch (ClassNotFoundException e) {
            System.out.println("Exception: " + e.toString());
            message = "Erro ao cadastrar livro: " + e.toString();
        }

        return message;
    }

    public List<Book> getAll() {
        try {
            BookDAO bookDAO = new BookDAO();
            return bookDAO.getAll();
        } catch (Exception e) {
            System.out.println("Exception: " + e.getMessage());
            return new ArrayList<>(0);
        }
    }

    public HashMap<String, String> getById(String id) {
        HashMap<String, String> bookMap = new HashMap<>();

        try {
            if (id.isEmpty()) {
                bookMap.put("message", "O campo id está vazio!");
                return bookMap;
            }

            BookDAO bookDAO = new BookDAO();
            HashMap<String, String> bookDaoMap = bookDAO.getById(Integer.parseInt(id));

            if (bookDaoMap.isEmpty()) {
                bookMap.put("message", "Livro não encontrado!");
                return bookMap;
            }

            bookMap.putAll(bookDaoMap);
        } catch (NumberFormatException e) {
            System.out.println("Exception: " + e.getMessage());
            bookMap.put("message", "Informe corretamente o id como valor inteiro!");
        } catch (Exception ex) {
            System.out.println("Exception: " + ex.getMessage());
            bookMap.put("message", ex.getMessage());
        }

        return bookMap;
    }

    public String deleteById(String id) {
        try {
            BookDAO bookDAO = new BookDAO();

            if (id.isEmpty()) {
                return "O campo id está vazio!";
            }

            boolean isDeletedProduct = bookDAO.deleteById(Integer.parseInt(id));

            if (isDeletedProduct) {
                return "Livro deletado com sucesso!";
            }
        } catch (NumberFormatException e) {
            System.out.println("Exception: " + e.getMessage());
            return "Informe corretamente o id como valor inteiro!";
        } catch (SQLException ex) {
            System.out.println("Exception: " + ex.getMessage());
            return ex.getMessage();
        } catch (Exception ex) {
            System.out.println("Exception: " + ex.getMessage());
            return ex.getMessage();
        }

        return "Erro ao deletar o livro!";
    }

    public String update(String id, String name, String author, String gender, String year, String edition, String readStatus, String totalPages, String readPages) throws ClassNotFoundException {
        String message;
        BookDAO bookDAO = new BookDAO();
        Book newBook = new Book();
        ReadStatusEnum readStatusEnum = null;
        int idParsed = Integer.parseInt(id);
        int totalPagesParsed = Integer.parseInt(totalPages);
        int readPagesParsed = 0;
        int editionParsed = 0;

        for (ReadStatusEnum value : ReadStatusEnum.values()) {
            if (value.getDescription().equals(readStatus)) {
                readStatusEnum = value;
            }
        }

        if (readPages != null && readPages.length() > 0) {
            readPagesParsed = Integer.parseInt(readPages);
        }

        if (edition != null && edition.length() > 0) {
            editionParsed = Integer.parseInt(edition);
        }

        if (readPagesParsed > totalPagesParsed) {
            return "O número de páginas lidas é maior que o total de páginas!";
        }

        newBook.setId(idParsed);
        newBook.setName(name);
        newBook.setAuthor(author);
        newBook.setGender(gender);
        newBook.setYear(year);
        newBook.setEdition(editionParsed);
        newBook.setReadStatus(readStatusEnum);
        newBook.setTotalPages(totalPagesParsed);
        newBook.setReadPages(readPagesParsed);

        try {
            if (bookDAO.update(newBook)) {
                message = "Livro atualizado com sucesso!";
            } else {
                message = "Erro ao atualizar livro!";
            }
        } catch (Exception e) {
            System.out.println("Exception: " + e.toString());
            message = "Erro ao atualizar livro: " + e.toString();
        }

        return message;
    }

    public List<Book> getAllReadBooks() {
        try {
            BookDAO bookDAO = new BookDAO();
            return bookDAO.getByReadStatus(ReadStatusEnum.READ);
        } catch (Exception e) {
            System.out.println("Exception: " + e.getMessage());
            return new ArrayList<>(0);
        }
    }

    public List<Book> getAllUnreadBooks() {
        try {
            BookDAO bookDAO = new BookDAO();
            return bookDAO.getByReadStatus(ReadStatusEnum.NOT_READ);
        } catch (Exception e) {
            System.out.println("Exception: " + e.getMessage());
            return new ArrayList<>(0);
        }
    }

    public List<Book> getAllInProgressReadBooks() {
        try {
            BookDAO bookDAO = new BookDAO();
            return bookDAO.getByReadStatus(ReadStatusEnum.IN_PROGRESS);
        } catch (Exception e) {
            System.out.println("Exception: " + e.getMessage());
            return new ArrayList<>(0);
        }
    }
}
