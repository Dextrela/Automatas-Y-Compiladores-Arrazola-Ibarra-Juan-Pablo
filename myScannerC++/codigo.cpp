// C++ program to demonstrate the use of classes, vectors, file handling, and exception handling
// Source: GeeksforGeeks - C++ Programming Examples

#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <algorithm>
#include <stdexcept>

using namespace std;

class Employee {
private:
    int id;
    string name;
    double salary;

public:
    Employee() : id(0), name(""), salary(0.0) {}

    Employee(int empId, string empName, double empSalary) {
        id = empId;
        name = empName;
        salary = empSalary;
    }

    int getId() const { return id; }
    string getName() const { return name; }
    double getSalary() const { return salary; }

    void setName(string newName) { name = newName; }
    void setSalary(double newSalary) { salary = newSalary; }

    void display() const {
        cout << "ID: " << id << ", Name: " << name << ", Salary: $" << salary << endl;
    }

    bool operator<(const Employee& other) const {
        return salary > other.salary;
    }
};

class EmployeeManager {
private:
    vector<Employee> employees;
    string filename;

    int findEmployeeById(int id) const {
        for (size_t i = 0; i < employees.size(); i++) {
            if (employees[i].getId() == id) {
                return i;
            }
        }
        return -1;
    }

public:
    EmployeeManager(string file = "employees.txt") : filename(file) {}

    void addEmployee(int id, string name, double salary) {
        if (findEmployeeById(id) != -1) {
            throw runtime_error("Employee ID already exists!");
        }
        employees.push_back(Employee(id, name, salary));
        cout << "Employee added successfully.\n";
    }

    void removeEmployee(int id) {
        int index = findEmployeeById(id);
        if (index == -1) {
            throw runtime_error("Employee not found!");
        }
        employees.erase(employees.begin() + index);
        cout << "Employee removed successfully.\n";
    }

    void displayAll() const {
        if (employees.empty()) {
            cout << "No employees to display.\n";
            return;
        }
        cout << "\n--- All Employees ---\n";
        for (const auto& emp : employees) {
            emp.display();
        }
        cout << "Total: " << employees.size() << " employees\n";
    }

    void searchEmployee(int id) const {
        int index = findEmployeeById(id);
        if (index == -1) {
            cout << "Employee with ID " << id << " not found.\n";
            return;
        }
        cout << "Employee found:\n";
        employees[index].display();
    }

    double calculateAverageSalary() const {
        if (employees.empty()) return 0.0;
        double total = 0.0;
        for (const auto& emp : employees) {
            total += emp.getSalary();
        }
        return total / employees.size();
    }

    void sortBySalary() {
        sort(employees.begin(), employees.end());
        cout << "Employees sorted by salary (highest first).\n";
    }

    void saveToFile() {
        ofstream outFile(filename);
        if (!outFile.is_open()) {
            throw runtime_error("Cannot open file for writing!");
        }
        outFile << employees.size() << endl;
        for (const auto& emp : employees) {
            outFile << emp.getId() << endl;
            outFile << emp.getName() << endl;
            outFile << emp.getSalary() << endl;
        }
        outFile.close();
        cout << "Data saved to " << filename << endl;
    }

    void loadFromFile() {
        ifstream inFile(filename);
        if (!inFile.is_open()) {
            cout << "No existing file found. Starting fresh.\n";
            return;
        }
        employees.clear();
        int n;
        inFile >> n;
        inFile.ignore();
        for (int i = 0; i < n; i++) {
            int id;
            string name;
            double salary;
            inFile >> id;
            inFile.ignore();
            getline(inFile, name);
            inFile >> salary;
            inFile.ignore();
            employees.push_back(Employee(id, name, salary));
        }
        inFile.close();
        cout << "Loaded " << employees.size() << " employees from file.\n";
    }
};

void showMenu() {
    cout << "\n=== EMPLOYEE MANAGEMENT SYSTEM ===\n";
    cout << "1. Add Employee\n";
    cout << "2. Remove Employee\n";
    cout << "3. Display All Employees\n";
    cout << "4. Search Employee by ID\n";
    cout << "5. Calculate Average Salary\n";
    cout << "6. Sort Employees by Salary\n";
    cout << "7. Save to File\n";
    cout << "8. Load from File\n";
    cout << "0. Exit\n";
    cout << "Enter your choice: ";
}

int main() {
    EmployeeManager manager;
    int choice;

    try {
        manager.loadFromFile();
    } catch (const exception& e) {
        cout << "Error loading file: " << e.what() << endl;
    }

    do {
        showMenu();
        cin >> choice;

        try {
            switch (choice) {
                case 1: {
                    int id;
                    string name;
                    double salary;
                    cout << "Enter ID: ";
                    cin >> id;
                    cout << "Enter Name: ";
                    cin.ignore();
                    getline(cin, name);
                    cout << "Enter Salary: ";
                    cin >> salary;
                    manager.addEmployee(id, name, salary);
                    break;
                }
                case 2: {
                    int id;
                    cout << "Enter ID to remove: ";
                    cin >> id;
                    manager.removeEmployee(id);
                    break;
                }
                case 3:
                    manager.displayAll();
                    break;
                case 4: {
                    int id;
                    cout << "Enter ID to search: ";
                    cin >> id;
                    manager.searchEmployee(id);
                    break;
                }
                case 5: {
                    double avg = manager.calculateAverageSalary();
                    cout << "Average Salary: $" << avg << endl;
                    break;
                }
                case 6:
                    manager.sortBySalary();
                    break;
                case 7:
                    manager.saveToFile();
                    break;
                case 8:
                    manager.loadFromFile();
                    break;
                case 0:
                    cout << "Exiting system...\n";
                    break;
                default:
                    cout << "Invalid choice! Try again.\n";
            }
        } catch (const exception& e) {
            cout << "ERROR: " << e.what() << endl;
        }
    } while (choice != 0);

    char save;
    cout << "Save changes before exit? (y/n): ";
    cin >> save;
    if (save == 'y' || save == 'Y') {
        try {
            manager.saveToFile();
        } catch (const exception& e) {
            cout << "Error saving: " << e.what() << endl;
        }
    }

    cout << "Program terminated.\n";
    return 0;
}