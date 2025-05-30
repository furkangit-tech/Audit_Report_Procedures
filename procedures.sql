-- USP_LogApplicantChanges
CREATE PROCEDURE [ocrapi].[USP_LogApplicantChanges]
    @ApplicantId INT,
    @VerifiedBy INT,
    @FirstName VARCHAR(255),
    @LastName VARCHAR(255),
    @PermanentAddress VARCHAR(255),
    @State VARCHAR(255),
    @District VARCHAR(255),
    @Block VARCHAR(255),
    @Pincode VARCHAR(20),
    @DateOfBirth VARCHAR(20),
    @Gender VARCHAR(50),
    @Category VARCHAR(255),
    @MaritalStatus VARCHAR(20),
    @Occupation VARCHAR(255),
    @WorkingDays VARCHAR(50),
    @PlaceOfWork VARCHAR(255),
    @IfscCode VARCHAR(50),
    @BankAccountNumber VARCHAR(50),
    @MobileNumber VARCHAR(50),
    @OtherStateRegistrationNumber VARCHAR(255),
    @Panchayat VARCHAR(255),
    @ContributionPercentage VARCHAR(10),
    @BankName VARCHAR(255),
    @RegistrationNumber VARCHAR(50),
    @RegistrationDate VARCHAR(50),
    @RelationTypeId INT,
    @RelativeName VARCHAR(255),
    @MissingRegId BIT,
    @IsImmigrant BIT,
    @ActionDetails NVARCHAR(MAX) OUTPUT,
    @Status VARCHAR(50) = 'Success',
    @Reason VARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @OldFirstName VARCHAR(255),
            @OldLastName VARCHAR(255),
            @OldPermanentAddress VARCHAR(255),
            @OldState VARCHAR(255),
            @OldDistrict VARCHAR(255),
            @OldBlock VARCHAR(255),
            @OldPincode VARCHAR(20),
            @OldDateOfBirth VARCHAR(20),
            @OldGender VARCHAR(50),
            @OldCategory VARCHAR(255),
            @OldMaritalStatus VARCHAR(20),
            @OldOccupation VARCHAR(255),
            @OldWorkingDays VARCHAR(50),
            @OldPlaceOfWork VARCHAR(255),
            @OldIfscCode VARCHAR(50),
            @OldBankAccountNumber VARCHAR(50),
            @OldMobileNumber VARCHAR(50),
            @OldOtherStateRegistrationNumber VARCHAR(255),
            @OldPanchayat VARCHAR(255),
            @OldContributionPercentage VARCHAR(10),
            @OldBankName VARCHAR(255),
            @OldRegistrationNumber VARCHAR(50),
            @OldRegistrationDate VARCHAR(50),
            @OldRelativeName VARCHAR(255),
            @OldMissingRegId BIT,
            @OldIsImmigrant BIT,
            @OldRelationTypeId INT;

    -- Get old values
    SELECT 
        @OldFirstName = first_name,
        @OldLastName = last_name,
        @OldPermanentAddress = permanent_address,
        @OldState = state,
        @OldDistrict = district,
        @OldBlock = block,
        @OldPincode = pincode,
        @OldDateOfBirth = date_of_birth,
        @OldGender = gender,
        @OldCategory = category,
        @OldMaritalStatus = marital_status,
        @OldOccupation = occupation,
        @OldWorkingDays = working_days,
        @OldPlaceOfWork = place_of_work,
        @OldIfscCode = ifsc_code,
        @OldBankAccountNumber = bank_account_number,
        @OldMobileNumber = mobile_number,
        @OldOtherStateRegistrationNumber = other_state_registration_number,
        @OldPanchayat = panchayat,
        @OldContributionPercentage = contribution_percentage,
        @OldBankName = bank_name,
        @OldRegistrationNumber = registration_number,
        @OldRegistrationDate = registration_date,
        @OldRelationTypeId = relationtype_id,
        @OldRelativeName = relative_name,
        @OldMissingRegId = missing_reg_id,
        @OldIsImmigrant = is_immigrant
    FROM applicants
    WHERE ocr_result_id = @ApplicantId;

    -- Build action_details JSON for changed fields
    DECLARE @Changes TABLE (FieldName VARCHAR(100), OldValue NVARCHAR(255), NewValue NVARCHAR(255));
    
    -- Compare all fields for changes
    IF @OldFirstName != @FirstName
        INSERT INTO @Changes (FieldName, OldValue, NewValue) VALUES ('first_name', @OldFirstName, @FirstName);
    IF @OldLastName != @LastName
        INSERT INTO @Changes (FieldName, OldValue, NewValue) VALUES ('last_name', @OldLastName, @LastName);
    IF @OldPermanentAddress != @PermanentAddress
        INSERT INTO @Changes (FieldName, OldValue, NewValue) VALUES ('permanent_address', @OldPermanentAddress, @PermanentAddress);
    IF @OldState != @State
        INSERT INTO @Changes (FieldName, OldValue, NewValue) VALUES ('state', @OldState, @State);
    IF @OldDistrict != @District
        INSERT INTO @Changes (FieldName, OldValue, NewValue) VALUES ('district', @OldDistrict, @District);
    IF @OldBlock != @Block
        INSERT INTO @Changes (FieldName, OldValue, NewValue) VALUES ('block', @OldBlock, @Block);
    IF @OldPincode != @Pincode
        INSERT INTO @Changes (FieldName, OldValue, NewValue) VALUES ('pincode', @OldPincode, @Pincode);
    IF @OldDateOfBirth != @DateOfBirth
        INSERT INTO @Changes (FieldName, OldValue, NewValue) VALUES ('date_of_birth', @OldDateOfBirth, @DateOfBirth);
    IF @OldGender != @Gender
        INSERT INTO @Changes (FieldName, OldValue, NewValue) VALUES ('gender', @OldGender, @Gender);
    IF @OldCategory != @Category
        INSERT INTO @Changes (FieldName, OldValue, NewValue) VALUES ('category', @OldCategory, @Category);
    IF @OldMaritalStatus != @MaritalStatus
        INSERT INTO @Changes (FieldName, OldValue, NewValue) VALUES ('marital_status', @OldMaritalStatus, @MaritalStatus);
    IF @OldOccupation != @Occupation
        INSERT INTO @Changes (FieldName, OldValue, NewValue) VALUES ('occupation', @OldOccupation, @Occupation);
    IF @OldWorkingDays != @WorkingDays
        INSERT INTO @Changes (FieldName, OldValue, NewValue) VALUES ('working_days', @OldWorkingDays, @WorkingDays);
    IF @OldPlaceOfWork != @PlaceOfWork
        INSERT INTO @Changes (FieldName, OldValue, NewValue) VALUES ('place_of_work', @OldPlaceOfWork, @PlaceOfWork);
    IF @OldIfscCode != @IfscCode
        INSERT INTO @Changes (FieldName, OldValue, NewValue) VALUES ('ifsc_code', @OldIfscCode, @IfscCode);
    IF @OldBankAccountNumber != @BankAccountNumber
        INSERT INTO @Changes (FieldName, OldValue, NewValue) VALUES ('bank_account_number', @OldBankAccountNumber, @BankAccountNumber);
    IF @OldMobileNumber != @MobileNumber
        INSERT INTO @Changes (FieldName, OldValue, NewValue) VALUES ('mobile_number', @OldMobileNumber, @MobileNumber);
    IF @OldOtherStateRegistrationNumber != @OtherStateRegistrationNumber
        INSERT INTO @Changes (FieldName, OldValue, NewValue) VALUES ('other_state_registration_number', @OldOtherStateRegistrationNumber, @OtherStateRegistrationNumber);
    IF @OldPanchayat != @Panchayat
        INSERT INTO @Changes (FieldName, OldValue, NewValue) VALUES ('panchayat', @OldPanchayat, @Panchayat);
    IF @OldContributionPercentage != @ContributionPercentage
        INSERT INTO @Changes (FieldName, OldValue, NewValue) VALUES ('contribution_percentage', @OldContributionPercentage, @ContributionPercentage);
    IF @OldBankName != @BankName
        INSERT INTO @Changes (FieldName, OldValue, NewValue) VALUES ('bank_name', @OldBankName, @BankName);
    IF @OldRegistrationNumber != @RegistrationNumber
        INSERT INTO @Changes (FieldName, OldValue, NewValue) VALUES ('registration_number', @OldRegistrationNumber, @RegistrationNumber);
    IF @OldRegistrationDate != @RegistrationDate
        INSERT INTO @Changes (FieldName, OldValue, NewValue) VALUES ('registration_date', @OldRegistrationDate, @RegistrationDate);
    IF @OldRelationTypeId != @RelationTypeId
        INSERT INTO @Changes (FieldName, OldValue, NewValue) VALUES ('relation_type_id', CAST(@OldRelationTypeId AS NVARCHAR(255)), CAST(@RelationTypeId AS NVARCHAR(255)));
    IF @OldRelativeName != @RelativeName
        INSERT INTO @Changes (FieldName, OldValue, NewValue) VALUES ('relative_name', @OldRelativeName, @RelativeName);
    IF @OldMissingRegId != @MissingRegId
        INSERT INTO @Changes (FieldName, OldValue, NewValue) VALUES ('missing_reg_id', CASE @OldMissingRegId WHEN 1 THEN 'true' ELSE 'false' END, CASE @MissingRegId WHEN 1 THEN 'true' ELSE 'false' END);
    IF @OldIsImmigrant != @IsImmigrant
        INSERT INTO @Changes (FieldName, OldValue, NewValue) VALUES ('is_immigrant', CASE @OldIsImmigrant WHEN 1 THEN 'true' ELSE 'false' END, CASE @IsImmigrant WHEN 1 THEN 'true' ELSE 'false' END);

    -- Set ActionDetails based on changes
    SET @ActionDetails = (
        SELECT FieldName, OldValue, NewValue
        FROM @Changes
        FOR JSON PATH
    );

    -- If no changes, set ActionDetails to empty JSON array
    IF @ActionDetails IS NULL
        SET @ActionDetails = '[]';

    IF @Reason IS NULL
	BEGIN
		SET @Reason = CASE 
						WHEN JSON_VALUE(@ActionDetails, '$[0].OldValue') IS NOT NULL THEN 'Change'
						ELSE 'Update'
					 END;
	END
	
	IF @ActionDetails IS NOT NULL AND @ActionDetails <> '[]'
	BEGIN
		INSERT INTO [audit_log] (
			user_id,
			applicant_id,
			edit_applicant,
			status,
			reason,
			action_details
		)
		VALUES (
			@VerifiedBy,
			@ApplicantId,
			'UPDATE',
			@Status,
			@Reason,
			@ActionDetails
		);
	END
END;

-- SP_GetAuditReport
CREATE PROCEDURE [ocrapi].[SP_GetAuditReport]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        al.id,
        al.user_id,
        u.name AS user_name,
        al.applicant_id,
		al.edit_applicant,
		al.status,
        al.reason,
        al.action_details,
        al.created_at,
        al.updated_at
    FROM [audit_log] al WITH (NOLOCK)
    JOIN [users] u ON al.user_id = u.id
    ORDER BY al.created_at DESC;
END;

-- USP_UpdateApplicantsData_AuditReport_Test
CREATE PROCEDURE [ocrapi].[USP_UpdateApplicantsData_AuditReport_Test]      
    @ApplicantId INT,                 
    @IsVerified BIT,
    @verified_by int,                  
    @FirstName VARCHAR(255),           
    @LastName VARCHAR(255),            
    @ApplicantName VARCHAR(255),       
    @PermanentAddress VARCHAR(255),       
    @State VARCHAR(255),              
    @District VARCHAR(255),           
    @Block VARCHAR(255),              
    @Pincode VARCHAR(20),            
    @DateOfBirth VARCHAR(20),                
    @Gender VARCHAR(50),              
    @Category VARCHAR(255),           
    @MaritalStatus VARCHAR(20),       
    @Occupation VARCHAR(255),         
    @WorkingDays VARCHAR(50),        
    @AadhaarNumber VARCHAR(50),       
    @PlaceOfWork VARCHAR(255),
    @IfscCode VARCHAR(50),           
    @BankAccountNumber VARCHAR(50),       
    @MobileNumber VARCHAR(50),      
    @IsOtherStateRegistered BIT,       
    @OtherRegisteredState VARCHAR(255),       
    @OtherStateRegistrationNumber VARCHAR(255),       
    @JurisdictionLabourOffice VARCHAR(255),
    @Panchayat VARCHAR(255),
    @ContributionPercentage VARCHAR(10),
    @BankName VARCHAR(255),
    @LockExpirationDate VARCHAR(50),
    @RegistrationNumber VARCHAR(50),   
    @RegistrationDate VARCHAR(50),
    @RelationTypeId INT,
    @RelativeName VARCHAR(255),
  	@MissingRegId BIT,
  	@IsImmigrant BIT,
    @EmployerCompanyName VARCHAR(255),
    @EmployerAddress VARCHAR(255),
    @EmployerTehsil VARCHAR(50),
    @EmployerDistrict VARCHAR(50),
    @EmployerState VARCHAR(50),
    @EmployerPincode VARCHAR(10),
    @LabourWelfareOfficeName VARCHAR(255),
    @LabourWelfareOfficeAddress VARCHAR(255),
    @LabourWelfareOfficeTehsil VARCHAR(50),
    @LabourWelfareOfficeDistrict NVARCHAR(255),
    @LabourWelfareOfficePincode VARCHAR(10),
    @StatusCode INT OUTPUT,               
    @Message NVARCHAR(255) OUTPUT         
AS      
BEGIN      
    SET NOCOUNT ON;          
	
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
    BEGIN TRANSACTION;      
    BEGIN TRY              
         DECLARE @OcrId INT, @EmployerId INT, @LabourWelfareOfficeId INT;
		     DECLARE @ActionDetails NVARCHAR(MAX) = '[]';
													
        -- Get IDs from the applicants table
        SELECT 
			@OcrId = ocr_result_id, 
			@EmployerId = employer_id,
			@LabourWelfareOfficeId = labour_welfare_office_id
		    FROM applicants      
		WHERE ocr_result_id = @ApplicantId;

        IF @OcrId IS NOT NULL      
        BEGIN      
            IF NOT EXISTS(SELECT TOP 1 1 FROM applicants WITH (NOLOCK) WHERE ocr_result_id = @ApplicantId AND ISNULL(LockExpirationDate, GETDATE()) > GETDATE())
            BEGIN
                SET @StatusCode = 405;
                SET @Message = 'Editing a locked record is not allowed';
                ROLLBACK TRANSACTION;
                RETURN;
            END
            ELSE 
            BEGIN
			
				-- Call audit log procedure
                EXEC [ocrapi].[USP_LogApplicantChanges]
                    @ApplicantId,
                    @verified_by,
                    @FirstName,
                    @LastName,
                    @PermanentAddress,
                    @State,
                    @District,
                    @Block,
                    @Pincode,
                    @DateOfBirth,
                    @Gender,
                    @Category,
                    @MaritalStatus,
                    @Occupation,
                    @WorkingDays,
                    @PlaceOfWork,
                    @IfscCode,
                    @BankAccountNumber,
                    @MobileNumber,
                    @OtherStateRegistrationNumber,
                    @Panchayat,
                    @ContributionPercentage,
                    @BankName,
                    @RegistrationNumber,
                    @RegistrationDate,
                    @RelationTypeId,
                    @RelativeName,
                    @MissingRegId,
                    @IsImmigrant,
                    @ActionDetails OUTPUT;

                -- Update OCR Table      
                UPDATE ocr_orchestrator      
                SET      
                    is_verified = @IsVerified,
                    verified_by = @verified_by,        
                    verification_date = CASE WHEN @IsVerified = 1 THEN GETDATE() ELSE NULL END,
                    updated_on = GETDATE()        
                WHERE id = @OcrId;    

                -- Update Applicant Table      
                UPDATE applicants      
                SET      
                    first_name = @FirstName,      
                    last_name = @LastName,      
                    applicant_name = @ApplicantName,      
                    permanent_address = @PermanentAddress,      
                    state = @State,      
                    district = @District,      
                    block = @Block,      
                    pincode = @Pincode,      
                    date_of_birth = @DateOfBirth,      
                    gender = @Gender,      
                    category = @Category,      
                    marital_status = @MaritalStatus,      
                    occupation = @Occupation,      
                    working_days = @WorkingDays,      
                    aadhaar_number = @AadhaarNumber,      
                    place_of_work = @PlaceOfWork,      
                    ifsc_code = @IfscCode,      
                    bank_account_number = @BankAccountNumber,      
                    mobile_number = @MobileNumber,      
                    is_other_state_registered = @IsOtherStateRegistered,      
                    other_registered_state = @OtherRegisteredState,      
                    other_state_registration_number = @OtherStateRegistrationNumber,      
                    jurisdiction_labour_office = @JurisdictionLabourOffice,
                    panchayat = @Panchayat,
                    contribution_percentage = @ContributionPercentage,
                    bank_name = @BankName,
                    LockExpirationDate = @LockExpirationDate,
                    registration_number = @RegistrationNumber,  
                    registration_date = @RegistrationDate,
                    relationtype_id = @RelationTypeId, 
                    relative_name = @RelativeName, 
					missing_reg_id = @MissingRegId,
					is_immigrant = @IsImmigrant,
					system_verified = 1,
					LockedByUserId = 0,
					system_verification_date = GETDATE(),
                    updated_on = GETDATE()        
                WHERE ocr_result_id = @ApplicantId;

                -- Handle Labour Welfare Office
                IF @LabourWelfareOfficeId IS NULL
                BEGIN
                    INSERT INTO labourWelfareOffice (name, address, district, tehsil, pincode)
                    VALUES (@LabourWelfareOfficeName, @LabourWelfareOfficeAddress, @LabourWelfareOfficeDistrict, @LabourWelfareOfficeTehsil, @LabourWelfareOfficePincode);

                    SET @LabourWelfareOfficeId = SCOPE_IDENTITY();

                    UPDATE applicants
                    SET labour_welfare_office_id = @LabourWelfareOfficeId
                    WHERE ocr_result_id = @ApplicantId;
                END
                ELSE
                BEGIN
                    UPDATE labourWelfareOffice
                    SET
                        name = @LabourWelfareOfficeName,
                        address = @LabourWelfareOfficeAddress,
                        district = @LabourWelfareOfficeDistrict,
                        tehsil = @LabourWelfareOfficeTehsil,
                        pincode = @LabourWelfareOfficePincode
                    WHERE id = @LabourWelfareOfficeId;
                END;

                -- Handle Employer
                IF @EmployerId IS NULL
                BEGIN
                    INSERT INTO employer (name, address, tehsil, district, state, pincode)
                    VALUES (@EmployerCompanyName, @EmployerAddress, @EmployerTehsil, @EmployerDistrict, @EmployerState, @EmployerPincode);

                    SET @EmployerId = SCOPE_IDENTITY();

                    UPDATE applicants
                    SET employer_id = @EmployerId
                    WHERE ocr_result_id = @ApplicantId;
                END
                ELSE
                BEGIN
                    UPDATE employer
                    SET
                        name = @EmployerCompanyName,
                        address = @EmployerAddress,
                        tehsil = @EmployerTehsil,
                        district = @EmployerDistrict,
                        state = @EmployerState,
                        pincode = @EmployerPincode
                    WHERE id = @EmployerId;
                END;

                SET @StatusCode = 200;  
                SET @Message = 'Update successful';      

				UPDATE audit_log
				SET status = 'Success',
					reason = @Message
				WHERE applicant_id = @ApplicantId
				  AND created_at = (
					  SELECT MAX(created_at)
					  FROM audit_log
					  WHERE applicant_id = @ApplicantId
				  );
                COMMIT TRANSACTION;
                RETURN;
            END
        END      
        ELSE      
        BEGIN      
            SET @StatusCode = 404; 
            SET @Message = 'Applicant does not exist, skipping update.';
            ROLLBACK TRANSACTION; -- Ensure rollback
            RETURN;
        END      
    END TRY      
    BEGIN CATCH      
        IF @@TRANCOUNT > 0      
            ROLLBACK TRANSACTION; -- Ensure rollback on error
        SET @StatusCode = 500;  
        SET @Message = 'Error: ' + ERROR_MESSAGE();
        PRINT @Message
		RETURN; 
    END CATCH      
END;
