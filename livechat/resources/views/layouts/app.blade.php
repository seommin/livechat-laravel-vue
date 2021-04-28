<!doctype html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSRF Token -->
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <title>{{ config('app.name', 'Laravel') }}</title>

    <!-- Styles -->
    <link href="{{ mix('css/app.css') }}" rel="stylesheet">
</head>

<body class="bg-gray-100 h-screen antialiased leading-none">
    <div id="app" class="h-full">
        <div class="h-full flex flex-col">
            <header class="flex-initial bg-blue-900 shadow py-6">
                <div class="container mx-auto flex justify-between items-center px-6">
                    <div>
                        <a href="{{ url('/') }}" class="text-lg font-semibold text-gray-100 no-underline">
                            {{ config('app.name', 'Laravel') }}
                        </a>
                    </div>
                    <nav class="space-x-4 text-gray-300 text-sm sm:text-base">
                        @guest
                        <a class="no-underline hover:underline" href="{{ route('login') }}">{{ __('Login') }}</a>
                        @if (Route::has('register'))
                        <a class="no-underline hover:underline" href="{{ route('register') }}">{{ __('Register') }}</a>
                        @endif
                        @else
                        <span>{{ Auth::user()->name }}</span>

                        <a href="{{ route('logout') }}" class="no-underline hover:underline" onclick="event.preventDefault();
                                document.getElementById('logout-form').submit();">{{ __('Logout') }}</a>
                        <form id="logout-form" action="{{ route('logout') }}" method="POST" class="hidden">
                            {{ csrf_field() }}
                        </form>
                        @endguest
                    </nav>
                </div>
            </header>

            @yield('content')
        </div>
    </div>

    <!-- Scripts -->
    <script src="{{ mix('js/app.js') }}"></script>
</body>

</html>