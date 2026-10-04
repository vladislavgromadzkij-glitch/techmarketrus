#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <cstdlib>

int main(int argc, char *argv[])
{
    // 1. Инициализация окружения GUI
    QGuiApplication app(argc, argv);

    // Метаданные платформы (определяют каталоги настроек и кэширования)
    QGuiApplication::setOrganizationName(QStringLiteral("TechMarket"));
    QGuiApplication::setApplicationName(QStringLiteral("TechMarket-Core"));
    QGuiApplication::setOrganizationDomain(QStringLiteral("techmarket.internal"));

    // 2. Инициализация движка выполнения QML
    QQmlApplicationEngine engine;

    // 3. Безопасное завершение при сбое компоновки графа объектов QML
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(EXIT_FAILURE); },
        Qt::QueuedConnection
    );

    // 4. Загрузка целевого бинарного модуля QML
    engine.loadFromModule(QStringLiteral("TechMarket"), QStringLiteral("Main"));

    // 5. Проверка целостности графа визуализации
    if (engine.rootObjects().isEmpty()) {
        return EXIT_FAILURE;
    }

    // 6. Запуск бесконечного цикла обработки сигналов и событий
    return app.exec();
}