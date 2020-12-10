create table utilisateur
(
    utilisateur_id smallint    not null
        constraint utilisateur_pk
            primary key,
    nom            varchar(30) not null,
    prenom         varchar(30) not null,
    pseudo         varchar(30) not null,
    mot_de_passe   varchar(30) not null
);

alter table utilisateur
    owner to yannickdriever;

create table client
(
    client_id      integer      not null
        constraint client_pk
            primary key,
    telephone      varchar(10)  not null,
    mail           varchar(100) not null,
    utilisateur_id smallint     not null
        constraint utilisateur_client_fk
            references utilisateur
);

alter table client
    owner to yannickdriever;

create table facture
(
    facture_numero   integer       not null
        constraint facture_pk
            primary key,
    date             timestamp     not null,
    nom_client       varchar(30)   not null,
    libelle_commande varchar(100)  not null,
    total_ttc        numeric(4, 2) not null,
    client_id        integer       not null
        constraint client_facture_fk
            references client
);

alter table facture
    owner to yannickdriever;

create table point_de_vente
(
    point_de_vente_id smallserial  not null
        constraint point_de_vente_pk
            primary key,
    raison_sociale    varchar(50)  not null,
    adresse           varchar(100) not null,
    telephone         varchar(10)  not null,
    mail              varchar(100) not null,
    gerant            varchar(30)  not null
);

alter table point_de_vente
    owner to yannickdriever;

create table stock
(
    stock_id          smallint      not null
        constraint stock_pk
            primary key,
    categorie         varchar(30)   not null,
    nom_produit       varchar(30)   not null,
    nom_ingredient    varchar(30)   not null,
    fournisseur       varchar(30)   not null,
    quantite          numeric(3, 1) not null,
    point_de_vente_id smallint      not null
        constraint point_de_vente_stock_fk
            references point_de_vente
);

alter table stock
    owner to yannickdriever;

create table produit
(
    pizza_id         smallint      not null
        constraint produit_pk
            primary key,
    categorie        varchar(30)   not null,
    nom              varchar(30)   not null,
    descriptif       varchar(100)  not null,
    prix_unitaire_ht numeric(4, 2) not null,
    taux_tva_100     numeric(3, 1) not null,
    stock_id         smallint      not null
        constraint stock_produit_fk
            references stock
);

alter table produit
    owner to yannickdriever;

create table personnel
(
    personnel_id      smallint    not null
        constraint personnel_pk
            primary key,
    fonction          varchar(30) not null,
    point_de_vente_id smallint    not null
        constraint point_de_vente_personnel_fk
            references point_de_vente,
    utilisateur_id    smallint    not null
        constraint utilisateur_personnel_fk
            references utilisateur,
    nom               varchar(30) not null
);

alter table personnel
    owner to yannickdriever;

create table commande
(
    commande_numero   integer       not null
        constraint commande_pk
            primary key,
    date              timestamp     not null,
    etat              varchar       not null,
    nom_client        varchar(30)   not null,
    libelle           varchar(100)  not null,
    preparateur       smallint      not null
        constraint commande_personnel_personnel_id_fk
            references personnel,
    adresse_livraison varchar(100)  not null,
    prix_ttc          numeric(4, 2) not null,
    client_id         integer       not null
        constraint client_commande_fk
            references client,
    point_de_vente_id smallint      not null
        constraint point_de_vente_commande_fk
            references point_de_vente
);

alter table commande
    owner to yannickdriever;

create table adresse
(
    adresse_id      integer     not null
        constraint adresse_pk
            primary key,
    nom_client      varchar(30) not null,
    numero_voie     smallint    not null,
    voie            varchar(50) not null,
    code_postal     integer     not null,
    ville           varchar(50) not null,
    commande_numero integer     not null
        constraint commande_adresse_fk
            references commande,
    client_id       integer     not null
        constraint client_adresse_fk
            references client
);

alter table adresse
    owner to yannickdriever;

create table livraison
(
    livraison_numero  integer      not null
        constraint livraison_pk
            primary key,
    date              timestamp    not null,
    livreur           varchar(30)  not null,
    nom_client        varchar(30)  not null,
    adresse_livraison varchar(100) not null,
    commande_numero   integer      not null
        constraint commande_livraison_fk
            references commande,
    facture_numero    integer      not null
        constraint facture_livraison_fk
            references facture
);

alter table livraison
    owner to yannickdriever;

create table ligne_de_commande
(
    commande_numero   integer       not null
        constraint commande_ligne_de_commande_fk
            references commande,
    produit_id        smallint      not null
        constraint produit_ligne_de_commande_fk
            references produit,
    nom_produit       varchar(30)   not null,
    prix_unitaire_ttc numeric(4, 2) not null,
    quantite          smallint      not null,
    constraint ligne_de_commande_pk
        primary key (commande_numero, produit_id)
);

alter table ligne_de_commande
    owner to yannickdriever;

create table composition
(
    ingredient_id smallint not null
        constraint composition_stock_stock_id_fk
            references stock,
    pizza_id      smallint not null
        constraint composition_pk
            primary key
        constraint composition_pizza_pizza_id_fk
            references produit,
    quantite      smallint not null
);

alter table composition
    owner to yannickdriever;

