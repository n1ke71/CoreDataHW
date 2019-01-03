//
//  Utils.h
//  CoreDataHW
//
//  Created by Kozaderov Ivan on 24/12/2018.
//  Copyright © 2018 n1ke71. All rights reserved.
//

#ifndef Utils_h
#define Utils_h

static NSString* firstNames[] = {
    @"Tran", @"Lenore", @"Bud", @"Fredda", @"Katrice",
    @"Clyde", @"Hildegard", @"Vernell", @"Nellie", @"Rupert",
    @"Billie", @"Tamica", @"Crystle", @"Kandi", @"Caridad",
    @"Vanetta", @"Taylor", @"Pinkie", @"Ben", @"Rosanna",
    @"Eufemia", @"Britteny", @"Ramon", @"Jacque", @"Telma",
    @"Colton", @"Monte", @"Pam", @"Tracy", @"Tresa",
    @"Willard", @"Mireille", @"Roma", @"Elise", @"Trang",
    @"Ty", @"Pierre", @"Floyd", @"Savanna", @"Arvilla",
    @"Whitney", @"Denver", @"Norbert", @"Meghan", @"Tandra",
    @"Jenise", @"Brent", @"Elenor", @"Sha", @"Jessie"
};

static NSString* lastNames[] = {
    @"Farrah", @"Laviolette", @"Heal", @"Sechrest", @"Roots",
    @"Homan", @"Starns", @"Oldham", @"Yocum", @"Mancia",
    @"Prill", @"Lush", @"Piedra", @"Castenada", @"Warnock",
    @"Vanderlinden", @"Simms", @"Gilroy", @"Brann", @"Bodden",
    @"Lenz", @"Gildersleeve", @"Wimbish", @"Bello", @"Beachy",
    @"Jurado", @"William", @"Beaupre", @"Dyal", @"Doiron",
    @"Plourde", @"Bator", @"Krause", @"Odriscoll", @"Corby",
    @"Waltman", @"Michaud", @"Kobayashi", @"Sherrick", @"Woolfolk",
    @"Holladay", @"Hornback", @"Moler", @"Bowles", @"Libbey",
    @"Spano", @"Folson", @"Arguelles", @"Burke", @"Rook"
};

static NSString* adresses[] = {
    @"Farrah@gmail.com", @"Laviolette@gmail.com", @"Heal@gmail.com", @"Sechrest@gmail.com", @"Roots@gmail.com",
    @"Homan@gmail.com", @"Starns@gmail.com", @"Oldham@gmail.com", @"Yocum@gmail.com", @"Mancia@gmail.com",
    @"Prill@gmail.com", @"Lush@gmail.com", @"Piedra@gmail.com", @"Castenada@gmail.com", @"Warnock@gmail.com",
    @"Vanderlinden@gmail.com", @"Simms@gmail.com", @"Gilroy@gmail.com", @"Brann@gmail.com", @"Bodden@gmail.com",
    @"Lenz@gmail.com", @"Gildersleeve@gmail.com", @"Wimbish@gmail.com", @"Bello@gmail.com", @"Beachy@gmail.com",
    @"Jurado@gmail.com", @"William@gmail.com", @"Beaupre@gmail.com", @"Dyal@gmail.com", @"Doiron@gmail.com",
    @"Plourde@gmail.com", @"Bator@gmail.com", @"Krause@gmail.com", @"Odriscoll@gmail.com", @"Corby@gmail.com",
    @"Waltman@gmail.com", @"Michaud@gmail.com", @"Kobayashi@gmail.com", @"Sherrick@gmail.com", @"Woolfolk@gmail.com",
    @"Holladay@gmail.com", @"Hornback@gmail.com", @"Moler@gmail.com", @"Bowles@gmail.com", @"Libbey@gmail.com",
    @"Spano@gmail.com", @"Folson@gmail.com", @"Arguelles@gmail.com", @"Burke@gmail.com", @"Rook@gmail.com"
};

static NSString* technicalSubjects[] = {
    @"Maths", @"Phisics", @"Programming",@"Geometry",@"Chemistry",@"Geometry",@"Astronomy",@"Economics"
};

static NSString* humanitarianSubjects[] = {
    @"Biology",@"Art", @"Literature", @"Singing", @"Geography",@"Foreign Language", @"Hystory", @"Psychology"
};

typedef enum {
    TecknicalCourseNameNone,
    TecknicalCourseNameMathimatics,
    TecknicalCourseNameDevOps,
    TecknicalCourseNameSysAdministrating,
    TecknicalCourseNameTesting,
    TecknicalCourseNameSysArchitecture
} TecknicalCourseName;
TecknicalCourseName randomTechCourseName;

NSString * nameOfTechCourse(TecknicalCourseName name) {
    switch (name) {
        case TecknicalCourseNameNone:
            return @"None";
        case TecknicalCourseNameMathimatics:
            return @"Mathimatics";
        case TecknicalCourseNameDevOps:
            return @"DevOps";
        case TecknicalCourseNameSysAdministrating:
            return @"Administrating";
        case TecknicalCourseNameTesting:
            return @"Testing";
        case TecknicalCourseNameSysArchitecture:
            return @"System Architecture";
    }
}

typedef enum {
    HumanitarianCourseNameNone,
    HumanitarianCourseNameArt,
    HumanitarianCourseNameHistory,
    HumanitarianCourseNameMusic,
    HumanitarianCourseNameDesign,
    HumanitarianCourseNameArchitecture
} HumanitarianCourseName;
HumanitarianCourseName randomHumCourseName;

NSString * nameOfHumCourse(HumanitarianCourseName name) {
    switch (name) {
        case HumanitarianCourseNameNone:
            return @"None";
        case HumanitarianCourseNameArt:
            return @"Art";
        case HumanitarianCourseNameHistory:
            return @"History";
        case HumanitarianCourseNameMusic:
            return @"Music";
        case HumanitarianCourseNameDesign:
            return @"Design";
        case HumanitarianCourseNameArchitecture:
            return @"Architecture";
    }
}
#endif /* Utils_h */
