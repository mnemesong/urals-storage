package;

import UralsIdGenFunctions.genIntId;
import sneaker.assertion.Asserter.*;

function test1() {
    var stor = new UralsBasicStaticStorage(
        genIntId
    );
    stor.reInit(["alala", "blablabla", "ohoho"]);
    var readedAll = stor.readAll();
    assert(readedAll[0].id == 1);
    assert(readedAll[0].val == "alala");
    assert(readedAll[1].id == 2);
    assert(readedAll[1].val == "blablabla");
    assert(readedAll[2].id == 3);
    assert(readedAll[2].val == "ohoho");

    stor.reInit(["azaza", "gagaga"]);
    var readedAll = stor.readAll();
    assert(readedAll[0].id == 1);
    assert(readedAll[0].val == "azaza");
    assert(readedAll[1].id == 2);
    assert(readedAll[1].val == "gagaga");
}


function main() {
    test1();
}