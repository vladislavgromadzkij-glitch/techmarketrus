import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic

ApplicationWindow {
    id: root

    // =========================================================================
    // ОКОННАЯ ГЕОМЕТРИЯ И СИСТЕМНЫЕ СВОЙСТВА
    // =========================================================================
    width: 1100
    height: 750
    minimumWidth: 850
    minimumHeight: 620
    visible: true
    title: qsTr("TechMarket Core — Industrial & Hardware Exchange")

    // =========================================================================
    // СИСТЕМА ДИЗАЙНА (Webcore / Industrial Tech Palette)
    // =========================================================================
    readonly property var theme: ({
        bgApp:           "#0e1117", // Холст нижнего уровня
        bgSurface:       "#161b22", // Контейнеры верхнего уровня (хэдер, док)
        bgElevated:      "#21262d", // Интерактивные поля ввода и контролы
        borderSubtle:    "#30363d", // Разделительные контуры 1px
        borderAccent:    "#58a6ff", // Акцент фокуса поиска
        textPrimary:     "#f0f6fc", // Высококонтрастный текст
        textMuted:       "#8b949e", // Вторичные подписи, спецификации
        accentActive:    "#238636", // Статусный зеленый (проверено, EAC, онлайн)
        accentWarning:   "#d29922", // Предупреждение (б/у лоты, дефекты)
        accentDanger:    "#f85149", // Ошибки, нерабочие доноры
        accentCyan:      "#38bdf8"  // Webcore акцент навигации
    })

    color: theme.bgApp

    // =========================================================================
    // БАЗОВЫЙ КАРКАС КОМПОНОВКИ
    // =========================================================================
    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // ---------------------------------------------------------------------
        // 1. ВЕРХНЯЯ СЕРВИСНАЯ ПАНЕЛЬ (Header)
        // ---------------------------------------------------------------------
        Rectangle {
            id: headerBar
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            color: root.theme.bgSurface

            // Нижний аппаратный разделитель (1px divider)
            Rectangle {
                anchors.bottom: parent.bottom
                width: parent.width
                height: 1
                color: root.theme.borderSubtle
            }

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 16
                anchors.rightMargin: 16
                spacing: 12

                // Профиль инженера / статус юрлица
                Button {
                    id: accountBtn
                    Layout.preferredWidth: 42
                    Layout.preferredHeight: 42

                    background: Rectangle {
                        color: accountBtn.down ? root.theme.bgSurface : (accountBtn.hovered ? root.theme.bgElevated : "transparent")
                        radius: 8
                        border.color: root.theme.borderSubtle
                    }

                    contentItem: Text {
                        text: "👤"
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    onClicked: {
                        console.log("[Navigation] Открытие карточки учетной записи");
                    }
                }

                // Центральная терминальная строка поиска
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    color: root.theme.bgElevated
                    radius: 8
                    border.color: searchInput.activeFocus ? root.theme.borderAccent : root.theme.borderSubtle
                    border.width: 1

                    RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 12
                        anchors.rightMargin: 12
                        spacing: 8

                        Text {
                            text: "🔍"
                            color: root.theme.textMuted
                            font.pixelSize: 14
                        }

                        TextInput {
                            id: searchInput
                            Layout.fillWidth: true
                            color: root.theme.textPrimary
                            font.pixelSize: 13
                            font.family: "Monospace"
                            selectByMouse: true
                            clip: true

                            Text {
                                text: qsTr("Поиск по артикулу, ТР ТС, ревизии кристалла, названию схемы...")
                                color: root.theme.textMuted
                                font.pixelSize: 13
                                visible: !searchInput.text && !searchInput.activeFocus
                                anchors.verticalCenter: parent.verticalCenter
                            }

                            onAccepted: {
                                console.log("[Search Query Emitted]:", text);
                                // Связка с C++ контроллером фильтрации
                            }
                        }
                    }
                }

                // Параметры выборки / Глобальный конфигуратор
                Button {
                    id: settingsBtn
                    Layout.preferredWidth: 42
                    Layout.preferredHeight: 42

                    background: Rectangle {
                        color: settingsBtn.down ? root.theme.bgSurface : (settingsBtn.hovered ? root.theme.bgElevated : "transparent")
                        radius: 8
                        border.color: root.theme.borderSubtle
                    }

                    contentItem: Text {
                        text: "⚙"
                        font.pixelSize: 18
                        color: root.theme.textPrimary
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    onClicked: {
                        console.log("[Navigation] Глобальные параметры платформы");
                    }
                }
            }
        }

        // ---------------------------------------------------------------------
        // 2. ЦЕНТРАЛЬНАЯ РАБОЧАЯ ОБЛАСТЬ (StackLayout Роутер)
        // ---------------------------------------------------------------------
        StackLayout {
            id: mainStack
            Layout.fillWidth: true
            Layout.fillHeight: true
            currentIndex: 0 // Дефолтный экран — Каталог

            // ЭКРАН 0: Каталог оборудования и компонентов
            Rectangle {
                color: root.theme.bgApp

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 8

                    Text {
                        text: "📦  КАТАЛОГ ОБОРУДОВАНИЯ"
                        color: root.theme.textPrimary
                        font.pixelSize: 18
                        font.bold: true
                        Layout.alignment: Qt.AlignHCenter
                    }
                    Text {
                        text: "Витрина: оптовые градации, тех. спеки в превью, EAC сертификаты"
                        color: root.theme.textMuted
                        font.pixelSize: 13
                        Layout.alignment: Qt.AlignHCenter
                    }
                }
            }

            // ЭКРАН 1: Логистика, Заказы, Яндекс Доставка
            Rectangle {
                color: root.theme.bgApp

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 8

                    Text {
                        text: "🚚  ТРЕКИНГ И ДОСТАВКА"
                        color: root.theme.textPrimary
                        font.pixelSize: 18
                        font.bold: true
                        Layout.alignment: Qt.AlignHCenter
                    }
                    Text {
                        text: "Контроль упаковки (ESD, обрешетка), сопроводительные УПД/акты"
                        color: root.theme.textMuted
                        font.pixelSize: 13
                        Layout.alignment: Qt.AlignHCenter
                    }
                }
            }

            // ЭКРАН 2: Технические чаты и безопасные сделки
            Rectangle {
                color: root.theme.bgApp

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 8

                    Text {
                        text: "💬  ИНЖЕНЕРНЫЕ ЧАТЫ И ТОРГ"
                        color: root.theme.textPrimary
                        font.pixelSize: 18
                        font.bold: true
                        Layout.alignment: Qt.AlignHCenter
                    }
                    Text {
                        text: "Прямой диалог покупателя и вендора, протоколы согласования цен"
                        color: root.theme.textMuted
                        font.pixelSize: 13
                        Layout.alignment: Qt.AlignHCenter
                    }
                }
            }

            // ЭКРАН 3: Инженерный форум и База Знаний (Wiki)
            Rectangle {
                color: root.theme.bgApp

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 8

                    Text {
                        text: "⚡  ТЕХНИЧЕСКИЙ ФОРУМ И WIKI"
                        color: root.theme.textPrimary
                        font.pixelSize: 18
                        font.bold: true
                        Layout.alignment: Qt.AlignHCenter
                    }
                    Text {
                        text: "Обсуждение ревизий чипов, дампы прошивок, обмен схемами"
                        color: root.theme.textMuted
                        font.pixelSize: 13
                        Layout.alignment: Qt.AlignHCenter
                    }
                }
            }

            // ЭКРАН 4: Кабинет продавца и публикация
            Rectangle {
                color: root.theme.bgApp

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 8

                    Text {
                        text: "🏷  КАБИНЕТ ВЕНДОРА / ПОСТАВЩИКА"
                        color: root.theme.textPrimary
                        font.pixelSize: 18
                        font.bold: true
                        Layout.alignment: Qt.AlignHCenter
                    }
                    Text {
                        text: "Генерация лотов через нейросеть, комплаенс РФ, оптовые сетки цен"
                        color: root.theme.textMuted
                        font.pixelSize: 13
                        Layout.alignment: Qt.AlignHCenter
                    }
                }
            }
        }

        // ---------------------------------------------------------------------
        // 3. НИЖНЯЯ ПАНЕЛЬ УПРАВЛЕНИЯ (Webcore Dock)
        // ---------------------------------------------------------------------
        Rectangle {
            id: bottomNavBar
            Layout.fillWidth: true
            Layout.preferredHeight: 62
            color: root.theme.bgSurface

            Rectangle {
                anchors.top: parent.top
                width: parent.width
                height: 1
                color: root.theme.borderSubtle
            }

            RowLayout {
                anchors.fill: parent
                spacing: 0

                // Инлайн-компонент навигационного элемента
                component NavButton: Button {
                    id: btn
                    property int targetIndex: 0
                    property string iconSymbol: ""
                    property string btnLabel: ""

                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    background: Rectangle {
                        color: btn.down ? root.theme.bgElevated : "transparent"

                        // Неоновый индикатор активной вкладки
                        Rectangle {
                            anchors.top: parent.top
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: mainStack.currentIndex === btn.targetIndex ? 42 : 0
                            height: 2
                            color: root.theme.accentCyan
                            radius: 1

                            Behavior on width {
                                NumberAnimation { duration: 160; easing.type: Easing.OutCubic }
                            }
                        }
                    }

                    contentItem: ColumnLayout {
                        spacing: 3
                        anchors.centerIn: parent

                        Text {
                            text: btn.iconSymbol
                            font.pixelSize: 15
                            Layout.alignment: Qt.AlignHCenter
                        }

                        Text {
                            text: btn.btnLabel
                            font.pixelSize: 11
                            font.weight: mainStack.currentIndex === btn.targetIndex ? Font.DemiBold : Font.Normal
                            color: mainStack.currentIndex === btn.targetIndex ? root.theme.textPrimary : root.theme.textMuted
                            Layout.alignment: Qt.AlignHCenter

                            Behavior on color {
                                ColorAnimation { duration: 150 }
                            }
                        }
                    }

                    onClicked: {
                        mainStack.currentIndex = btn.targetIndex;
                    }
                }

                // 5 функциональных модулей
                NavButton { targetIndex: 0; iconSymbol: "📦"; btnLabel: qsTr("Каталог") }
                NavButton { targetIndex: 1; iconSymbol: "🚚"; btnLabel: qsTr("Заказы") }
                NavButton { targetIndex: 2; iconSymbol: "💬"; btnLabel: qsTr("Чаты") }
                NavButton { targetIndex: 3; iconSymbol: "⚡"; btnLabel: qsTr("Форум") }
                NavButton { targetIndex: 4; iconSymbol: "🏷"; btnLabel: qsTr("Кабинет") }
            }
        }
    }
}