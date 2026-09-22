/*
Two security personnel monitor access to a high-security vault in a secure facility.  Each security personnel is assigned a unique access card.  
The facility’s security system is designed only to access the vault when both security personnel present their access cards simultaneously.  
Design a digital circuit that ensures the vault door opens only when both access cards are presented.
Details:
AccCardA and AccCardB : Each card is represented by a binary signal. 
						When a card is presented, it sends a signal of '1'. 
						If the card is not presented, it sends a signal of '0'.

VaultDoor: The vault door control mechanism will receive the output of the circuit and will only open when the output is '1'.
*/

module VaultSecurity (
					  input AccCardA,
					  input AccCardB,
					  output VaultDoor
					  );

assign VaultDoor = AccCardA & AccCardB;

endmodule