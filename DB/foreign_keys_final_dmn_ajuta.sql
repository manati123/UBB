use Final_Lab_Doamne_Ajuta

ALTER TABLE Certification
ADD FOREIGN KEY (freelancer_id) REFERENCES Freelancer(freelancer_id)

ALTER TABLE Test_Result
ADD FOREIGN KEY (freelancer_id) REFERENCES Freelancer(freelancer_id),
FOREIGN KEY (test_id) REFERENCES Test(test_id)

ALTER TABLE Has_Skill
ADD FOREIGN KEY (freelancer_id) REFERENCES Freelancer(freelancer_id),
FOREIGN KEY (skill_id) REFERENCES Skill(skill_id)

ALTER TABLE Proposal
ADD FOREIGN KEY (skill_id) REFERENCES Skill(skill_id),
FOREIGN KEY (complexity_id) REFERENCES Complexity(complexity_id),
FOREIGN KEY (payment_type_id) REFERENCES payment_type(payment_type_id),
FOREIGN KEY (company_id) REFERENCES Company(company_id)

ALTER TABLE Contract
ADD FOREIGN KEY (proposal_id) REFERENCES Proposal(proposal_id),
FOREIGN KEY (freelancer_id) REFERENCES Freelancer(freelancer_id)