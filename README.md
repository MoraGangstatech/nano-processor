# Nano Processor

This repository contains the final project for CS1050 Computer Organization and Digital Design course, focusing on the development of a Nano Processor.

## Project Structure

```plaintext
nano-processor/
|-- cons/            // Constraint files
|-- docs/            // Documents related to the project
|-- np_project/      // Vivado project (ignored)
|-- rtl/
|   |-- design/      // RTL design files
|   |-- simulation/  // Simulation files
|-- .gitignore       // Git ignore rules
|-- README.md        // Project readme
|-- rebuild.tcl      // TCL script for rebuilding project
```

## Setup

### Install Vivado

Vivado 2018.1 is required for this project. It's essential to use this exact version to ensure compatibility and facilitate IP reuse.

### Setting up the Console Environment

To make the `vivado` command available for building the project using TCL, follow one of the methods below:

- #### Add Vivado Binaries to the PATH

  Add `<installation_dir>\Vivado\2018.1\bin` to the [system PATH](https://www.architectryan.com/2018/03/17/add-to-the-path-on-windows-10/). This step needs to be done only once per machine and is suitable for a single Vivado installation.

- #### Execute Vivado Console Setup

  Execute `"<installation_dir>\Vivado\2018.1\settings64.bat"` in the command prompt every time you open it. This method helps keep your PATH clean but requires execution each time you open a console.

### Clone the Repository

Clone this repository to your local machine using Git.

### Rebuild the Project

After cloning the repository, navigate to the project directory in the command prompt and run `rebuild.bat`. This will rebuild the Vivado project linking vhd(l), XDC files found according to the [Project Structure](#project-structure).

### Open the Project

Locate the `np_project.xpr` file inside the *np_project* directory to open the project in Vivado.

## Contributing Guidelines

To ensure a smooth collaboration process and maintain consistency across the project, please follow these guidelines:

### General Styling Guidelines

- Follow consistent naming conventions for files, variables, and modules.
- Use meaningful names that accurately describe the purpose of each component.
- Adhere to the existing coding style and formatting standards.

### Organization

- Place files outside the `np_project` directory into appropriate directories based on their purpose (e.g., constraint files in `cons/`, documents in `docs/`, etc.).
- Utilize version control effectively to track changes and maintain project integrity.

### Pull Requests

- Submit pull requests for proposed changes or additions.
- Provide clear and detailed descriptions of the changes included in the pull request.
- Ensure that the changes adhere to the project's coding standards and guidelines.
- Address any feedback or requested modifications promptly.

By adhering to these guidelines, group members can help maintain a well-organized and consistent project structure, making collaboration more efficient and effective. Thank you for your contributions to the Nano Processor project!
