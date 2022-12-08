USE Chinook;
# -------------------- TRIGGERS -----------------------

CREATE TRIGGER aumentaValorG
    BEFORE INSERT
    ON Genre
    FOR EACH ROW
BEGIN
    SET new.GenreId = (SELECT MAX(GenreId) + 1 FROM Genre);
END;

CREATE TRIGGER aumentaValorM
    BEFORE INSERT
    ON MediaType
    FOR EACH ROW
BEGIN
    SET new.MediaTypeId = (SELECT MAX(MediaTypeId) + 1 FROM MediaType);
END;

CREATE TRIGGER aumentaValorPL
    BEFORE INSERT
    ON Playlist
    FOR EACH ROW
BEGIN
    SET new.PlaylistId = (SELECT MAX(PlaylistId) + 1 FROM Playlist);
END;

CREATE TRIGGER aumentaValorAR
    BEFORE INSERT
    ON Artist
    FOR EACH ROW
BEGIN
    SET new.ArtistId = (SELECT MAX(ArtistId) + 1 FROM Artist);
END;

CREATE TRIGGER aumentaValorAlb
    BEFORE INSERT
    ON Album
    FOR EACH ROW
BEGIN
    SET new.AlbumId = (SELECT MAX(AlbumId) + 1 FROM Artist);
END;

# ---------------------------------------------------------------


delimiter //
CREATE PROCEDURE newGenre(
    IN name_genre varchar(120)
)
BEGIN
    declare done int default FALSE;
    declare name_g varchar(120);
    declare recorreGenre cursor for
        SELECT Name FROM Genre;

    declare continue handler for not found set done = true;

    open recorreGenre;
    read_loop:
    loop
        fetch recorreGenre INTO name_g;
        IF (name_g LIKE name_genre) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Genre lready exists';
        END IF;
        IF done then
            leave read_loop;
        end IF;
    end loop;

    close recorreGenre;
    INSERT INTO Genre values (null, name_genre);
end;

delimiter //

CREATE PROCEDURE newMediaType(
    IN name_mt_ varchar(120)
)
BEGIN
    declare done int default FALSE;
    declare name_mt varchar(120);
    declare recorreMT cursor for
        SELECT Name FROM MediaType;

    declare continue handler for not found set done = true;

    open recorreMT;
    read_loop:
    loop
        fetch recorreMT INTO name_mt;
        IF (name_mt LIKE name_mt_) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'MediaType already exists';
        END IF;
        IF done then
            leave read_loop;
        end IF;
    end loop;

    close recorreMT;
    INSERT INTO MediaType values (null, name_mt_);
end;
delimiter //


CREATE PROCEDURE newPlayList(
    IN name_pl_ varchar(120)
)
BEGIN
    declare done int default FALSE;
    declare name_pl varchar(120);
    declare recorrePL cursor for
        SELECT Name FROM Playlist;

    declare continue handler for not found set done = true;

    open recorrePL;
    read_loop:
    loop
        fetch recorrePL INTO name_pl;
        IF (name_pl LIKE name_pl_) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Playlist already exists';
        END IF;
        IF done then
            leave read_loop;
        end IF;
    end loop;

    close recorrePL;
    INSERT INTO Playlist values (null, name_pl_);
end;

delimiter //

CREATE PROCEDURE newArtist(
    IN name_ar_ varchar(120)
)
BEGIN
    declare done int default FALSE;
    declare name_ar varchar(120);
    declare recorreAR cursor for
        SELECT Name FROM Artist;

    declare continue handler for not found set done = true;

    open recorreAR;
    read_loop:
    loop
        fetch recorreAR INTO name_ar;
        IF (name_ar LIKE name_ar_) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Artist already exists';
        END IF;
        IF done then
            leave read_loop;
        end IF;
    end loop;

    close recorreAR;
    INSERT INTO Artist values (null, name_ar_);
end;

delimiter //

# ------------------------------ Testes ------------------------------------------
#Novo Genre
CALL newGenre('Trapp');
SELECT *
FROM Genre;

#Novo mediaType
CALL newMediaType('Mp4t1');
SELECT *
FROM MediaType;

#Nova Playlist
CALL newPlayList('Hits Bad Bunny Verano');
SELECT *
FROM Playlist;

#Nova Artist
CALL newArtist('Bad Bunny');
CALL newArtist('Bad Bunny');
SELECT *
FROM Artist;