allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Set custom build directory for all subprojects
subprojects {
    buildDir = file("${rootProject.projectDir}/../build/${project.name}")
}

tasks.register<Delete>("clean") {
    delete(rootProject.buildDir)
}
