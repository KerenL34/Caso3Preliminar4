Use EsencialVerde

CREATE PROCEDURE ObtenerEstadosYPaises
    @countryId INT
AS
BEGIN
    SELECT States.name AS Estado, Countries.name AS Pais
    FROM States
    INNER JOIN Countries ON Countries.countryId = States.countryId
    WHERE Countries.countryId = @countryId
END
