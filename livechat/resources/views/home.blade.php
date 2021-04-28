@extends('layouts.app')

@section('content')
<div class="flex-1">
    <chat-component :current-user="{{ auth()->id() }}"></chat-component>
</div>
@endsection