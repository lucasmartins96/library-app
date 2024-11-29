<%-- 
    Document   : index
    Created on : 18 de nov. de 2024, 22:13:38
    Author     : lmartins96
--%>

<%@page import="util.ReadStatusEnum"%>
<%@page import="java.util.HashMap"%>
<%@page import="controller.BookController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../assets/bootstrap/bootstrap.min.css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <title>Detalhes do Livro</title>
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
                                    <a href="../em-leitura/" class="nav-link link-body-emphasis">
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
                                <div class="col-lg-9 col-md-8 mx-auto">
                                    <h1 class="fw-light">Detalhes do Livro</h1>
                                    <p class="lead text-body-secondary">
                                        Veja todas as informações detalhadas sobre este livro da sua coleção.
                                        Aqui você pode conferir o título, autor, gênero, ano de publicação e outras observações.
                                        Caso necessário, edite ou exclua o registro para manter sua coleção sempre atualizada.
                                    </p>
                                    <p>
                                        <button id="enableUpdateBook" type="button" class="btn btn-primary my-2 me-2">Editar Livro</button>
                                        <button type="button" class="btn btn-danger my-2 ms-2" data-bs-toggle="modal" data-bs-target="#deleteBookModal">Excluir Livro</button>
                                    </p>
                                </div>
                            </div>
                        </section>
                        <%
                            // Captura a parte dinâmica da URL
                            String pathInfo = request.getPathInfo(); // Ex: "/123"
                            String bookId = (pathInfo != null && pathInfo.length() > 1) ? pathInfo.substring(1) : null;

                            if (bookId != null) {
                                BookController controller = new BookController();
                                HashMap<String, String> bookFoundMap = new HashMap<>();
                                bookFoundMap = controller.getById(bookId);
                                String message = bookFoundMap.get("message");

                                if (message != null && message.length() > 0) {
                        %>
                        <div class="w-100 text-center">
                            <p class="text-danger"><%= message%></p>
                            <a href="../" class="btn btn-primary">Voltar para a lista de livros</a>
                        </div>
                        <%
                        } else {
                        %>
                        <form class="mx-auto w-75" id="updateBookForm">
                            <input type="hidden" class="form-control" id="bookId" name="bookId" value="<%= bookId%>">
                            <div class="mb-3">
                                <label for="bookName" class="form-label">Nome*</label>
                                <input type="text" class="form-control" id="bookName" name="bookName" placeholder="Ex: Como fazer amigos e influenciar pessoas" value="<%= bookFoundMap.get("name")%>" disabled>
                            </div>
                            <div class="mb-3">
                                <label for="bookAuthor" class="form-label">Autor*</label>
                                <input type="text" class="form-control" id="bookAuthor" name="bookAuthor" placeholder="Ex: Dale Carnegie" value="<%= bookFoundMap.get("author")%>" disabled>
                            </div>
                            <div class="mb-3">
                                <label for="bookGender" class="form-label">Gênero*</label>
                                <input type="text" class="form-control" id="bookGender" name="bookGender" placeholder="Ex: Negócios" value="<%= bookFoundMap.get("gender")%>" disabled>
                            </div>
                            <div class="mb-3">
                                <label for="bookYear" class="form-label">Ano*</label>
                                <input type="number" class="form-control" id="bookYear" name="bookYear" placeholder="Ex: 2024" value="<%= bookFoundMap.get("year")%>" disabled>
                            </div>
                            <div class="mb-3">
                                <label for="bookEdition" class="form-label">Edição</label>
                                <input type="number" class="form-control" id="bookEdition" name="bookEdition" value="<%= bookFoundMap.get("edition")%>" disabled>
                            </div>
                            <div class="mb-3">
                                <label for="bookNumberPages" class="form-label">Páginas*</label>
                                <input type="number" class="form-control" id="bookNumberPages" name="bookNumberPages" placeholder="Ex: 100" value="<%= bookFoundMap.get("total_pages")%>" disabled>
                            </div>
                            <div class="mb-3">
                                <label class="form-label me-4">Status:</label>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="bookIsRead" id="bookIsReadRadio" value="read" <%= bookFoundMap.get("read_status").equals(ReadStatusEnum.READ.getDescription()) ? "checked" : ""%> disabled>
                                    <label class="form-check-label" for="bookIsReadRadio">
                                        Lido
                                    </label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="bookIsRead" id="bookIsNotReadRadio" value="not_read" <%= bookFoundMap.get("read_status").equals(ReadStatusEnum.NOT_READ.getDescription()) ? "checked" : ""%> disabled>
                                    <label class="form-check-label" for="bookIsNotReadRadio">
                                        Não lido
                                    </label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="bookIsRead" id="bookIsProgressReadRadio" value="progress" <%= bookFoundMap.get("read_status").equals(ReadStatusEnum.IN_PROGRESS.getDescription()) ? "checked" : ""%> disabled>
                                    <label class="form-check-label" for="bookIsProgressReadRadio">
                                        Em Leitura
                                    </label>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="bookReadNumberPages" class="form-label">Páginas lidas</label>
                                <input type="number" class="form-control" id="bookReadNumberPages" name="bookReadNumberPages" value="<%= bookFoundMap.get("read_pages")%>" disabled>
                            </div>
                            <div class="d-grid py-4 gap-2 col-6 mx-auto" id="btnUpdateBookContainer">
                                <button class="btn btn-primary" type="submit">
                                    Atualizar
                                </button>
                            </div>

                            <!-- Modals -->
                            <!-- FeedbackBookModal -->
                            <div class="modal fade" id="detailsFeedbackBookModal" tabindex="-1" aria-labelledby="detailsFeedbackBookModalLabel" aria-hidden="false">
                                <div class="modal-dialog modal-dialog-centered">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title fs-5" id="detailsFeedbackBookModalLabel"></h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body" id="detailsFeedbackBookModalMessage"></div>
                                    </div>
                                </div>
                            </div>

                            <!-- FeedbackDeleteBookModal -->
                            <div class="modal fade" id="feedbackDeleteBookModal" tabindex="-1" aria-labelledby="feedbackDeleteBookModalLabel" aria-hidden="false">
                                <div class="modal-dialog modal-dialog-centered">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title fs-5" id="feedbackDeleteBookModalLabel">Excluir Livro</h5>
                                            <button id="feedbackDeleteBookModalClose" type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body" id="feedbackDeleteBookModalMessage"></div>
                                    </div>
                                </div>
                            </div>

                            <!-- DeleteBookModal -->
                            <div class="modal fade" id="deleteBookModal" tabindex="-1" aria-labelledby="deleteBookModalLabel" aria-hidden="false">
                                <div class="modal-dialog modal-dialog-centered modal-sm">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title fs-5" id="deleteBookModalLabel">Excluir Livro</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body" id="modalMessage">
                                            <p>Tem certeza que quer excluir o livro <strong><%= bookFoundMap.get("name")%></strong>?</p>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancelar</button>
                                            <button id="btnDeleteBook" type="button" data-bs-dismiss="modal" class="btn btn-danger">Ok</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                        <%
                            }
                        } else {
                        %>
                        <div class="w-100 text-center">
                            <p class="text-danger">ID do livro inválido.</p>
                            <a href="../" class="btn btn-primary">Voltar para a lista de livros</a>
                        </div>
                        <%
                            }
                        %>
                    </div>
                </main>
            </div>

        </div>
        <script src="../assets/bootstrap/bootstrap.bundle.min.js"></script>
        <script src="../assets/js/jquery-3.7.1.min.js"></script>
        <script>
            function toggleEditMode() {
                const isDisabled = $('#bookName').is(':disabled'); // Campo referência para sinalizar o estado dos demais campos editáveis
                const cancelUpdateLabel = 'Cancelar Alterações';
                const updateLabel = 'Editar Livro';

                if (isDisabled) {
                    const isCheckedProgress = $('#bookIsProgressReadRadio').is(':checked'); // verifica se o status "Em leitura" está selecionado

                    $(this).html(cancelUpdateLabel); // Altera texto do botão

                    // Iteração em cada input do formulário
                    $('input').each(function () {
                        const inputType = $(this).prop('type');
                        const idValue = $(this).prop('id');
                        const isCommonInput = inputType !== "hidden" && idValue !== 'bookReadNumberPages'; // verifica outros inputs que não contenham o id "bookReadNumberPages"
                        const isInputBookReadNumberPages = idValue === 'bookReadNumberPages';

                        // habilita os demais inputs e também o input de número de páginas caso o status seja "Em leitura"
                        if ((isCommonInput) || (isInputBookReadNumberPages && isCheckedProgress)) {
                            $(this).prop('disabled', !isDisabled);
                        }
                    });
                    $('#btnUpdateBookContainer').removeClass('d-none'); // Exibe o botão Atualizar
                } else {
                    $(this).html(updateLabel); // Altera o texto do botão
                    $('input:not([type="hidden"])').prop('disabled', !isDisabled); // Desabilita todos os campos input, exceto o tipo "hidden"
                    $('#btnUpdateBookContainer').addClass('d-none'); // Esconde o botão Atualizar
                }
            }

            $(document).ready(function () {
                $('#updateBookForm').on('submit', function (e) {
                    toggleEditMode();
                    e.preventDefault();

                    $.ajax({
                        url: '/LibraryApp/actions/processarAtualizacao.jsp', // Arquivo JSP que processará os dados
                        method: 'POST',
                        data: $(this).serialize(), // Serializa os dados do formulário
                        success: function (response) {
                            // Atualiza o conteúdo do modal com a resposta
                            $('#detailsFeedbackBookModalLabel').html("Atualizar Livro");
                            $('#detailsFeedbackBookModalMessage').html(response);

                            // Exibe o modal de feedback
                            const feedbackModal = new bootstrap.Modal(document.getElementById('detailsFeedbackBookModal'));
                            feedbackModal.show();
                        },
                        error: function () {
                            $('#detailsFeedbackBookModalMessage').html("Ocorreu um erro ao processar sua solicitação.");
                            const feedbackModal = new bootstrap.Modal(document.getElementById('detailsFeedbackBookModal'));
                            feedbackModal.show();
                        }
                    });
                });

                $('#enableUpdateBook').click(toggleEditMode);

                $('#btnUpdateBookContainer').addClass('d-none');

                $('#btnDeleteBook').click(function () {
                    const id = $('#bookId').val();

                    $.ajax({
                        url: '/LibraryApp/actions/processarExclusao.jsp', // Arquivo JSP que processará os dados
                        method: 'POST',
                        data: {id},
                        success: function (response) {
                            // Atualiza o conteúdo do modal com a resposta
                            $('#feedbackDeleteBookModalMessage').html(response);

                            // Exibe o modal de feedback
                            const feedbackModal = new bootstrap.Modal(document.getElementById('feedbackDeleteBookModal'), {
                                backdrop: 'static'
                            });
                            feedbackModal.show();

                            // Redireciona para a home após 3 segundos
                            setTimeout(function () {
                                const appContext = window.location.pathname.split('/')[1];
                                const newPath = window.location.origin + '/' + appContext;
                                window.location.replace(newPath);
                            }, 3000);

                        },
                        error: function () {
                            $('#feedbackDeleteBookModalMessage').html("Ocorreu um erro ao processar sua solicitação.");
                            const feedbackModal = new bootstrap.Modal(document.getElementById('feedbackDeleteBookModal'));
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
