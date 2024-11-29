/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.dao;

import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import model.Book;
import util.ConnectionManagerSingleton;
import util.ReadStatusEnum;

/**
 *
 * @author Lucas Martins da Silva
 */
public class BookDAO {

    private final Connection connection;

    public BookDAO() throws ClassNotFoundException {
        this.connection = ConnectionManagerSingleton.getInstance().getConnection();
    }

    public boolean add(Book book) throws ClassNotFoundException {
        boolean isSuccessful;

        try {
            String insertQuery = "INSERT INTO book (name, author, gender, year, edition, read_status, total_pages, read_pages) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = this.connection.prepareStatement(insertQuery);
            statement.setString(1, book.getName()); // nome
            statement.setString(2, book.getAuthor()); // autor
            statement.setString(3, book.getGender()); // gênero
            statement.setString(4, book.getYear()); // ano
            statement.setInt(5, book.getEdition()); // edição
            statement.setString(6, book.getReadStatus().getDescription()); // status de leitura
            statement.setInt(7, book.getTotalPages()); // total de páginas
            statement.setInt(8, book.getReadPages()); // páginas lidas

            int rowsAffected = statement.executeUpdate();
            isSuccessful = rowsAffected > 0;
        } catch (SQLException ex) {
            System.out.println("SQL Exception: " + ex.toString());
            isSuccessful = false;
        } catch (Exception ex) {
            System.out.println("Exception: " + ex.toString());
            isSuccessful = false;
        }

        return isSuccessful;
    }

    public List<Book> getAll() throws Exception, SQLException {
        List<Book> allBooks = new ArrayList<>();
        ReadStatusEnum readStatusEnum = null;

        PreparedStatement statement = this.connection.prepareStatement("SELECT * FROM book");
        ResultSet resultSet = statement.executeQuery();

        while (resultSet.next()) {
            int id = resultSet.getInt("id");
            String name = resultSet.getString("name");
            String author = resultSet.getString("author");
            String gender = resultSet.getString("gender");
            String year = resultSet.getString("year");
            String readStatus = resultSet.getString("read_status");
            int totalPages = resultSet.getInt("total_pages");
            int readPages = resultSet.getInt("read_pages");
            int edition = resultSet.getInt("edition");

            for (ReadStatusEnum value : ReadStatusEnum.values()) {
                if (value.getDescription().equals(readStatus)) {
                    readStatusEnum = value;
                }
            }

            Book book = new Book(id, name, author, gender, year, edition, readStatusEnum, totalPages, readPages);

            allBooks.add(book);
        }

        return allBooks;
    }

    public HashMap<String, String> getById(int id) throws Exception {
        HashMap<String, String> bookMap = new HashMap<>();

        try {
            String findOneQuery = "SELECT * FROM book WHERE id = ?";
            PreparedStatement statement = this.connection.prepareStatement(findOneQuery);
            statement.setInt(1, id);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                bookMap.put("id", Integer.toString(resultSet.getInt("id")));
                bookMap.put("name", resultSet.getString("name"));
                bookMap.put("author", resultSet.getString("author"));
                bookMap.put("gender", resultSet.getString("gender"));
                bookMap.put("year", resultSet.getString("year"));
                bookMap.put("read_status", resultSet.getString("read_status"));
                bookMap.put("total_pages", Integer.toString(resultSet.getInt("total_pages")));
                bookMap.put("read_pages", Integer.toString(resultSet.getInt("read_pages")));
                bookMap.put("edition", Integer.toString(resultSet.getInt("edition")));
            }

        } catch (Exception e) {
            throw e;
        }

        return bookMap;
    }

    public boolean deleteById(int id) throws Exception {
        try {
            String deleteQuery = "DELETE FROM book WHERE id=?";
            PreparedStatement statement = this.connection.prepareStatement(deleteQuery);
            statement.setInt(1, id);

            int affectedRows = statement.executeUpdate();
            return affectedRows > 0;
        } catch (Exception e) {
            throw e;
        }
    }

    public boolean update(Book book) throws Exception {
        try {
            String updateQuery = "UPDATE book SET name=?, author=?, gender=?, year=?, edition=?, read_status=?, total_pages=?, read_pages=? WHERE id=?";
            PreparedStatement statement = this.connection.prepareStatement(updateQuery);
            statement.setString(1, book.getName()); // nome
            statement.setString(2, book.getAuthor()); // autor
            statement.setString(3, book.getGender()); // gênero
            statement.setString(4, book.getYear()); // ano
            statement.setInt(5, book.getEdition()); // edição
            statement.setString(6, book.getReadStatus().getDescription()); // status de leitura
            statement.setInt(7, book.getTotalPages()); // total de páginas
            statement.setInt(8, book.getReadPages()); // páginas lidas
            statement.setInt(9, book.getId()); // id

            int affectedRows = statement.executeUpdate();
            return affectedRows > 0;
        } catch (Exception e) {
            throw e;
        }
    }

    public List<Book> getByReadStatus(ReadStatusEnum status) throws Exception, SQLException {
        List<Book> allBooks = new ArrayList<>();

        PreparedStatement statement = this.connection.prepareStatement("SELECT * FROM book WHERE read_status = ?");
        statement.setString(1, status.getDescription());
        ResultSet resultSet = statement.executeQuery();

        while (resultSet.next()) {
            int id = resultSet.getInt("id");
            String name = resultSet.getString("name");
            String author = resultSet.getString("author");
            String gender = resultSet.getString("gender");
            String year = resultSet.getString("year");
            int totalPages = resultSet.getInt("total_pages");
            int readPages = resultSet.getInt("read_pages");
            int edition = resultSet.getInt("edition");

            Book book = new Book(id, name, author, gender, year, edition, status, totalPages, readPages);

            allBooks.add(book);
        }

        return allBooks;
    }
}
