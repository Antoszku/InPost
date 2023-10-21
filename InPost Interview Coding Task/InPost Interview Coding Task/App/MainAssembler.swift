import App
import DI
import Domain

struct MainAssembler {
    let resolver = Resolver()

    init() {
        AppAssembler(resolver: resolver)
        DomainAssembler(resolver: resolver)
    }
}
