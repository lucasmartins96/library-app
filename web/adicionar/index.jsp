<%-- 
    Document   : index
    Created on : 18 de nov. de 2024, 22:13:38
    Author     : lmartins96
--%>

<%@page import="util.ReadStatusEnum"%>
<%@page import="controller.BookController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../assets/bootstrap/bootstrap.min.css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <title>Adicionar Livro</title>
        <style>
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
                            <a href="../" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto link-body-emphasis text-decoration-none">
                                <i class="bi bi-book-half" style="font-size: 1.5rem; color: #0d6efd"></i>
                                <span class="fs-4 ms-2">MyLibraryApp</span>
                            </a>
                            <hr>
                            <ul class="nav nav-pills flex-column mb-auto">
                                <li class="nav-item">
                                    <a href="../" class="nav-link active" aria-current="page">
                                        Home
                                    </a>
                                </li>
                                <li>
                                    <a href="../adicionar/" class="nav-link link-body-emphasis">
                                        Livros em leitura
                                    </a>
                                </li>
                                <li>
                                    <a href="../lidos/" class="nav-link link-body-emphasis">
                                        Livro lidos
                                    </a>
                                </li>
                                <li>
                                    <a href="../nao-lidos/" class="nav-link link-body-emphasis">
                                        Livros não lidos
                                    </a>
                                </li>
                            </ul>
                            <hr>
                        </div>
                    </div>
                </div>
                <main class="col-md-9 ms-sm-auto col-xl-10 px-md-4">
                    <div class="container-fluid">
                        <section class="py-3 text-center container">
                            <div class="row py-lg-3">
                                <div class="col-lg-6 col-md-8 mx-auto">
                                    <h1 class="fw-light">Adicionar Novo Livro à Minha Coleção</h1>
                                    <p class="lead text-body-secondary">
                                        Organize sua coleção de livros!
                                        Adicione novos títulos com detalhes como autor, gênero, data de aquisição e uma breve observação pessoal.
                                        Esse registro facilitará o acompanhamento e organização de sua biblioteca pessoal.
                                    </p>
                                </div>
                            </div>
                        </section>
                        <form class="mx-auto w-75" id="registerBookForm">
                            <div class="mb-3">
                                <label for="bookName" class="form-label">Nome*</label>
                                <input type="text" class="form-control" id="bookName" name="bookName" placeholder="Ex: Como fazer amigos e influenciar pessoas">
                            </div>
                            <div class="mb-3">
                                <label for="bookAuthor" class="form-label">Autor*</label>
                                <input type="text" class="form-control" id="bookAuthor" name="bookAuthor" placeholder="Ex: Dale Carnegie">
                            </div>
                            <div class="mb-3">
                                <label for="bookGender" class="form-label">Gênero*</label>
                                <input type="text" class="form-control" id="bookGender" name="bookGender" placeholder="Ex: Negócios">
                            </div>
                            <div class="mb-3">
                                <label for="bookYear" class="form-label">Ano*</label>
                                <input type="number" class="form-control" id="bookYear" name="bookYear" placeholder="Ex: 2024">
                            </div>
                            <div class="mb-3">
                                <label for="bookEdition" class="form-label">Edição</label>
                                <input type="number" class="form-control" id="bookEdition" name="bookEdition">
                            </div>
                            <div class="mb-3">
                                <label for="bookNumberPages" class="form-label">Páginas*</label>
                                <input type="number" class="form-control" id="bookNumberPages" name="bookNumberPages" placeholder="Ex: 100">
                            </div>
                            <div class="mb-3">
                                <label class="form-label me-4">Status:</label>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="bookIsRead" id="bookIsReadRadio" value="read">
                                    <label class="form-check-label" for="bookIsReadRadio">
                                        Lido
                                    </label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="bookIsRead" id="bookIsNotReadRadio" value="not_read" checked>
                                    <label class="form-check-label" for="bookIsNotReadRadio">
                                        Não lido
                                    </label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="bookIsRead" id="bookIsProgressReadRadio" value="progress">
                                    <label class="form-check-label" for="bookIsProgressReadRadio">
                                        Em Leitura
                                    </label>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="bookReadNumberPages" class="form-label">Páginas lidas</label>
                                <input type="number" class="form-control" id="bookReadNumberPages" name="bookReadNumberPages" disabled>
                            </div>
                            <div class="d-grid py-4 gap-2 col-6 mx-auto">
                                <button class="btn btn-primary" type="submit">
                                    Cadastrar
                                </button>
                            </div>

                            <!-- Modal -->
                            <div class="modal fade" id="registerBookModal" tabindex="-1" aria-labelledby="registerBookModalLabel" aria-hidden="false">
                                <div class="modal-dialog modal-dialog-centered">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h1 class="modal-title fs-5" id="registerBookModalLabel">Salvar Novo Livro</h1>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body" id="modalMessage"></div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </main>
            </div>
        </div>
        <script src="../assets/bootstrap/bootstrap.bundle.min.js"></script>
        <script src="../assets/js/jquery-3.7.1.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#registerBookForm').on('submit', function (e) {
                    e.preventDefault();

                    $.ajax({
                        url: 'processarCadastro.jsp', // Arquivo JSP que processará os dados
                        method: 'POST',
                        data: $(this).serialize(), // Serializa os dados do formulário
                        success: function (response) {
                            // Atualiza o conteúdo do modal com a resposta
                            $('#modalMessage').html(response);

                            // Exibe o modal de feedback
                            const feedbackModal = new bootstrap.Modal(document.getElementById('registerBookModal'));
                            feedbackModal.show();
                        },
                        error: function () {
                            $('#modalMessage').html("Ocorreu um erro ao processar sua solicitação.");
                            const feedbackModal = new bootstrap.Modal(document.getElementById('registerBookModal'));
                            feedbackModal.show();
                        }
                    });
                });

                $('input[name="bookIsRead"]').change(function () {
                    const isRead = $('#bookIsProgressReadRadio').is(':checked');
                    $('#bookReadNumberPages').prop('disabled', !isRead);
                });
            });
        </script>
    </body>

</html>
