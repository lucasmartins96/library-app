<%-- 
    Document   : index
    Created on : 20 de nov. de 2024, 11:03:57
    Author     : lmartins96
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="controller.BookController"%>
<%@page import="model.Book"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--
Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Html.html to edit this template
-->
<html lang="pt-br">
    <head>
        <title>MyLibraryApp</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="./assets/bootstrap/bootstrap.min.css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <style>
            .bd-placeholder-img {
                font-size: 1.125rem;
                text-anchor: middle;
                -webkit-user-select: none;
                -moz-user-select: none;
                user-select: none;
            }

            .bd-mode-toggle {
                z-index: 1500;
            }

            .bd-mode-toggle .dropdown-menu .active .bi {
                display: block !important;
            }

            .button-open-menu {
                background-color: #0d6efd;
                top: 20px;
                left: 10px;
            }

            .sidebar-height {
                min-height: 100vh;
            }

            @media (min-width: 768px) {
                .bd-placeholder-img-lg {
                    font-size: 3.5rem;
                }
            }

            @media (max-width: 768px) {
                .sidebar-height {
                    min-height: unset;
                }
            }
        </style>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <button class="nav-link px-3 d-md-none position-fixed w-auto button-open-menu" type="button" data-bs-toggle="offcanvas" data-bs-target="#sidebarMenu" aria-controls="sidebarMenu" aria-expanded="false" aria-label="Toggle navigation">
                    <i class="bi bi-list" style="color: #fff"></i>
                </button>
                <div class="sidebar border border-right col-md-3 col-xl-2 p-0 bg-body-tertiary sidebar-height">
                    <div class="offcanvas-md offcanvas-start bg-body-tertiary w-auto p-2" tabindex="-1" id="sidebarMenu" aria-labelledby="sidebarMenuLabel">
                        <div class="offcanvas-body d-md-flex flex-column p-0 pt-lg-3 overflow-y-auto">
                            <a href="./" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto link-body-emphasis text-decoration-none">
                                <i class="bi bi-book-half" style="font-size: 1.5rem; color: #0d6efd"></i>
                                <span class="fs-4 ms-2">MyLibraryApp</span>
                            </a>
                            <hr>
                            <ul class="nav nav-pills flex-column mb-auto">
                                <li class="nav-item">
                                    <a href="./" class="nav-link active" aria-current="page">
                                        Home
                                    </a>
                                </li>
                                <li>
                                    <a href="./em-leitura/" class="nav-link link-body-emphasis">
                                        Livros em leitura
                                    </a>
                                </li>
                                <li>
                                    <a href="./lidos/" class="nav-link link-body-emphasis">
                                        Livro lidos
                                    </a>
                                </li>
                                <li>
                                    <a href="./nao-lidos/" class="nav-link link-body-emphasis">
                                        Livros não lidos
                                    </a>
                                </li>
                            </ul>
                            <hr>
                        </div>
                    </div>
                </div>
                <main class="col-md-9 ms-sm-auto col-xl-10 px-md-4">
                    <section class="py-4 text-center container">
                        <div class="row py-lg-3">
                            <div class="col-lg-9 col-md-8 mx-auto">
                                <h1 class="fw-light">Minha Coleção de Livros</h1>
                                <p class="lead text-body-secondary">
                                    Explore todos os livros da sua coleção pessoal em um único lugar.
                                    Aqui você pode visualizar, organizar e gerenciar seus títulos favoritos.
                                    Use as ferramentas de busca e filtros para encontrar livros rapidamente ou adicione novos títulos para expandir sua coleção!
                                </p>
                                <p>
                                    <a href="./adicionar/" class="btn btn-primary my-2">Novo Livro</a>
                                </p>
                            </div>
                        </div>
                    </section>
                    <div class="album py-4 bg-body-tertiary">
                        <div class="container-fluid">
                            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-2 row-cols-lg-3 row-cols-xl-4 g-3">
                                <%
                                    BookController controller = new BookController();
                                    List<Book> books = controller.getAll();

                                    if (!books.isEmpty()) {
                                        for (Book book : books) {
                                %>
                                <div class="col">
                                    <div class="card shadow-sm">
                                        <svg class="bd-placeholder-img card-img-top" width="100%" height="225" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: Thumbnail" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#55595c"/><text x="50%" y="50%" fill="#eceeef" dy=".3em">Thumbnail</text></svg>
                                        <div class="card-body">
                                            <h5 class="card-title"><%= book.getName()%></h5>
                                            <h6 class="card-subtitle mb-2 text-body-secondary"><%= book.getAuthor()%></h6>
                                            <div class="d-flex justify-content-between align-items-center">
                                                <div class="btn-group">
                                                    <a href="./book/<%= book.getId()%>" class="btn btn-sm btn-outline-secondary">Detalhes</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    }
                                } else {
                                %>
                                <div class="w-100 text-center">
                                    <p class="lead text-body-secondary">
                                        Parece que sua coleção está vazia no momento.
                                        Que tal começar a adicionar seus livros favoritos agora?
                                    </p>
                                    <p class="lead text-body-secondary">
                                        Clique no botão acima para registrar o primeiro livro e dar início à sua biblioteca pessoal!
                                    </p>
                                </div>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
        <script src="./assets/bootstrap/bootstrap.bundle.min.js"></script>
    </body>
</html>

