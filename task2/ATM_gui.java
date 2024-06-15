import java.sql.*;      //Interact with the data in Mysql database (Db name : Bank , Table name : Holder)
import javax.swing.*;   //For providing GUI to the application. Ex:textbox (JTextField)
import java.awt.event.*;//For handling Event like clicking the button
import java.awt.*;	   //For using class like Color used in setForegroundcolor()

class ATM_gui {
    static JTextField account;  //For account field
    static JPasswordField pin;	//For entering pin like dots appears for each characters entered
    static JTextArea output;	//To display status for each operation occured

    public static void main(String args[]) {
        JFrame f = new JFrame("TopperWorld ATM");     //Creating the frame
        f.setSize(600, 600);			      //Frame size
        f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        JPanel p = new JPanel();		      //Creating the panel		
        p.setLayout(null);
        
   
        Color custom_color = new Color(41, 32, 117);  //Set my own backgorund color from #292075 by RGB method here in Color()
        p.setBackground(custom_color);		          //Making #292075 as background color for the whole application
        f.add(p);	                 			      //Adding panel to frame
        place(p);
        f.setVisible(true);				
    }

    private static void place(JPanel p) {
        
        Color button_color = new Color(0, 181, 239);  //#00B5EF is the common background color
        
   	JLabel acc_label = new JLabel("Account no:");
        acc_label.setForeground(Color.WHITE);          //Setting white color to the Account no , Pin no labels
        acc_label.setBounds(10, 20, 120, 25); 	      
        p.add(acc_label);			      // Add the label to panel

        account = new JTextField(20);		      //Making the account no field input box	
        account.setBounds(150, 20, 200, 25);
        p.add(account);                               //Add the input field for account no to panel

        JLabel pin_label = new JLabel("Pin no:");
        pin_label.setForeground(Color.WHITE); 
        pin_label.setBounds(10, 50, 120, 25);
        p.add(pin_label);

        pin = new JPasswordField(20);
        pin.setBounds(150, 50, 200, 25);
        p.add(pin);

        JButton button_bal = new JButton("Check Balance");
        button_bal.setBounds(10, 90, 150, 25);
        button_bal.setBackground(button_color);
	button_bal.setForeground(Color.WHITE);        //Make the text inside the button as White using Color class
        p.add(button_bal);

        JButton button_dep = new JButton("Deposit");
        button_dep.setBounds(10, 120, 150, 25);
        button_dep.setBackground(button_color);
	button_dep.setForeground(Color.WHITE); 
        p.add(button_dep);

        JButton button_withd = new JButton("Withdraw");
        button_withd.setBounds(10, 150, 150, 25);
        button_withd.setBackground(button_color); 
	button_withd.setForeground(Color.WHITE);
        p.add(button_withd);

        JButton exits = new JButton("Exit");
        exits.setBounds(10, 180, 150, 25);
	exits.setForeground(Color.WHITE);
        exits.setBackground(button_color);
        p.add(exits);

        output = new JTextArea();		   //Going to show the status for each operation happened using TextArea()
        output.setBounds(10, 210, 350, 50);
        output.setEditable(false);		   //Make the status not write by the user
        p.add(output);

        button_bal.addActionListener(new ActionListener() {    //Adding event to the buttons
            public void actionPerformed(ActionEvent e) {
                balance();					//Function to check the current balance
            }
        });

        button_dep.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                deposit();					//Function to deposit amount
            }
        });

        button_withd.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                withdraw();					//Function to take amount from ATM
            }
        });

        exits.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                System.exit(0);					//Close the application
            }
        });
    }

    private static void balance() {
        String accounts = account.getText();
        char[] pins = pin.getPassword();

        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Bank", "root", "");
            Statement smt = conn.createStatement();
            ResultSet rs = smt.executeQuery("SELECT * FROM Holder WHERE acc_no = " + accounts);
            if (rs.next()) {
                if (rs.getInt("pin") == Integer.parseInt(new String(pins))) {
                    int balance = rs.getInt("balance");
                    output.setText("Your balance amount is: ₹" + balance);
                } else {
                    output.setText("Wrong pin entered");
                }
            } else {
                 output.setText("Your account is not found in our database");
            }
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static void deposit() {
        String accounts = account.getText();
        char[] pins = pin.getPassword();
        String deposit_amount = JOptionPane.showInputDialog("Enter the amount to deposit:");

        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Bank", "root", "");
            Statement smt = conn.createStatement();
            ResultSet rs = smt.executeQuery("SELECT * FROM Holder WHERE acc_no = " + accounts);
            if (rs.next()) {
                if (rs.getInt("pin") == Integer.parseInt(new String(pins))) {
                    int deposit = Integer.parseInt(deposit_amount);
                    int current = rs.getInt("balance");
                    int newBalance = deposit + current;
                    smt.executeUpdate("UPDATE Holder SET balance = " + newBalance + " WHERE acc_no = " + accounts);
                    output.setText("The amount ₹" + deposit + " deposited successfully.\nYour current balance amount is ₹" + newBalance);
                } else {
                    output.setText("Wrong pin entered");
                }
            } else {
                 output.setText("Your account number not found in our database");
            }
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static void withdraw() {
        String accounts = account.getText();
        char[] pins = pin.getPassword();
        String withdraw_amount = JOptionPane.showInputDialog("Enter amount to withdraw:");

        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Bank", "root", "");
            Statement smt = conn.createStatement();
            ResultSet rs = smt.executeQuery("SELECT * FROM Holder WHERE acc_no = " + accounts);
            if (rs.next()) {
                if (rs.getInt("pin") == Integer.parseInt(new String(pins))) {
                    int withdraw = Integer.parseInt(withdraw_amount);
                    int current = rs.getInt("balance");
                    if (withdraw <= current) {
                        int newBalance = current - withdraw;
                        smt.executeUpdate("UPDATE Holder SET balance = " + newBalance + " WHERE acc_no = " + accounts);
                        output.setText("₹" + withdraw + " withdrawn successfully.\nYour current balance amount is ₹" + newBalance);
                    } else {
                        output.setText("Your current entry exceeds your current balance amount.");
                    }
                } else {
                    output.setText("Wrong pin entered");
                }
            } else {
                output.setText("Your account number not found in our database");
            }
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
