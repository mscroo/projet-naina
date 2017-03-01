/*==============================================================*/
/* Nom de SGBD :  PostgreSQL 8                                  */
/* Date de création :  28/02/2017 13:40:09                      */
/*==============================================================*/


drop index MEMBRE_FK;

drop index VENTE_FK;

drop index ACHAT_PK;

drop table ACHAT;

drop index CATEGORISATION_FK;

drop index ARTICLE_PK;

drop table ARTICLE;

drop index MARQUE_PK;

drop table MARQUE;

drop index PAYE_FK;

drop index PAYEMENT_PK;

drop table PAYEMENT;

drop index UTILISATEUR_PK;

drop table UTILISATEUR;

/*==============================================================*/
/* Table : ACHAT                                                */
/*==============================================================*/
create table ACHAT (
   IDACHAT              SERIAL               not null,
   IDARTICLE            INT4                 not null,
   IDUTILISATEUR        INT4                 not null,
   QUANTITEACHETER      INT4                 not null,
   constraint PK_ACHAT primary key (IDACHAT)
);


create unique index ACHAT_PK on ACHAT (
IDACHAT
);

create  index VENTE_FK on ACHAT (
IDARTICLE
);


create  index MEMBRE_FK on ACHAT (
IDUTILISATEUR
);


create table ARTICLE (
   IDARTICLE            SERIAL               not null,
   IDMARQUE             INT4                 not null,
   NOMARTICLE           VARCHAR(100)         not null,
   PRIX                 MONEY                not null,
   QUANTITE             INT4                 not null,
   constraint PK_ARTICLE primary key (IDARTICLE)
);


create unique index ARTICLE_PK on ARTICLE (
IDARTICLE
);


create  index CATEGORISATION_FK on ARTICLE (
IDMARQUE
);


create table MARQUE (
   IDMARQUE             SERIAL               not null,
   NOMMARQUE            CHAR(10)             not null,
   constraint PK_MARQUE primary key (IDMARQUE)
);


create unique index MARQUE_PK on MARQUE (
IDMARQUE
);


create table PAYEMENT (
   IDPAYEMENT           SERIAL               not null,
   IDACHAT              INT4                 not null,
   MONTANTTOTAL         MONEY                not null,
   constraint PK_PAYEMENT primary key (IDPAYEMENT)
);


create unique index PAYEMENT_PK on PAYEMENT (
IDPAYEMENT
);


create  index PAYE_FK on PAYEMENT (
IDACHAT
);


create table UTILISATEUR (
   IDUTILISATEUR        SERIAL               not null,
   NOM                  VARCHAR(100)         not null,
   PRENOM               VARCHAR(100)         not null,
   PSEUDO               VARCHAR(100)         not null,
   EMAIL                VARCHAR(100)         not null,
   PASSWORD             VARCHAR(100)         not null,
   constraint PK_UTILISATEUR primary key (IDUTILISATEUR)
);


create unique index UTILISATEUR_PK on UTILISATEUR (
IDUTILISATEUR
);

alter table ACHAT
   add constraint FK_ACHAT_MEMBRE_UTILISAT foreign key (IDUTILISATEUR)
      references UTILISATEUR (IDUTILISATEUR)
      on delete restrict on update restrict;

alter table ACHAT
   add constraint FK_ACHAT_VENTE_ARTICLE foreign key (IDARTICLE)
      references ARTICLE (IDARTICLE)
      on delete restrict on update restrict;

alter table ARTICLE
   add constraint FK_ARTICLE_CATEGORIS_MARQUE foreign key (IDMARQUE)
      references MARQUE (IDMARQUE)
      on delete restrict on update restrict;

alter table PAYEMENT
   add constraint FK_PAYEMENT_PAYE_ACHAT foreign key (IDACHAT)
      references ACHAT (IDACHAT)
      on delete restrict on update restrict;

