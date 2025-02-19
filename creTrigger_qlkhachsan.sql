﻿USE QLKHACHSAN
GO

ALTER TABLE DMNHANVIEN
ADD CONSTRAINT CHK_GIOITINH CHECK (GIOITINH IN ('Nam', 'Nữ'));

ALTER TABLE DATPHONGCT
ADD CONSTRAINT CHK_NGAYDEN_NGAYDI CHECK (NGAYDEN < NGAYDI);


CREATE TRIGGER TRG_CHECKROOMSTATUSONINSERT
ON DATPHONGCT
FOR INSERT,  UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN DMPHONG p ON i.MAPHONG = p.MA
        WHERE p.TINHTRANG <> N'Trống'
    )
    BEGIN
        ROLLBACK TRANSACTION;
    END
END
GO


CREATE TRIGGER trg_KHACHHANGTRAPHONG
ON DATPHONGCT
AFTER DELETE
AS
BEGIN
 
    UPDATE DMPHONG
    SET TINHTRANG = 'Trống'
    FROM DMPHONG p
    INNER JOIN DELETED d ON p.MA = d.MAPHONG;
END
GO
