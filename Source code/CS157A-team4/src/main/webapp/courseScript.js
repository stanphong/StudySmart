let courses = [];

function addCourses() {
    const courseName = document.getElementById("courseName").value;
    const instructor = document.getElementById("instructor").value;
    const startDate = document.getElementById("startDate").value;
    const endDate = document.getElementById("endDate").value;

    if(!courseName || !instructor || !startDate || !endDate) {
        alert("Please fill in all fields");
        return;
    }

    courses.push({courseName, instructor, startDate, endDate});

    updateTable();
}

function removeCourse(index) {
    courses.splice(index, 1);
    updateTable();
}

function updateTable() {
    const tableBody = document.querySelector("#coursesTable tbody");
    tableBody.innerHTML = "";

    courses.forEach((course, index) => {
        const row = `<tr>
                        <td>${course.courseName}</td>
                        <td>${course.instructor}</td>
                        <td>${course.startDate}</td>
                        <td>${course.endDate}</td>
                        <td><button onclick="removeCourse(${index})">Remove</button></td>
                    </tr>`;
        tableBody.innerHTML += row;
    });
}
